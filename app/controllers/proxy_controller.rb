class ProxyController < ApplicationController

  CACHE_FOR = 5.minutes
  RACE_CONDITION_TTL = 20.seconds

  # GET /proxy/public/...
  def public_proxy
    resp = make_request(get_public_user, true)
    render json: resp.body, content_type: resp.headers['content-type'], status: resp.status
  end

  # GET /proxy/current/...
  def current_user_proxy
    if current_user
      resp = make_request(current_user)
      render json: resp.body, content_type: resp.headers['content-type'], status: resp.status
    else
      render text: 'Unauthorized', status: 401
    end
  end

protected

  # make a request as a remote user
  def make_request(remote_user, is_cached = false)
    opts = {
      url: remote_user.host,
      headers: {
        'User-Agent'    => 'pmp-support-app',
        'Accept'        => 'application/vnd.collection.doc+json',
        'Content-Type'  => 'application/vnd.collection.doc+json',
        'Authorization' => "Bearer #{remote_user.token}",
      },
      ssl: {verify: false},
    }
    path = (params[:other] || '')
    path << '?' + request.query_string if request.query_string.present?

    # cache remote call
    if is_cached
      key = [remote_user.env, remote_user.client_id, path]
      if cached_resp = Rails.cache.fetch(key, expires_in: CACHE_FOR, race_condition_ttl: RACE_CONDITION_TTL)
        cached_resp
      else
        resp = Faraday.new(opts).get(path)
        if resp.success?
          Rails.cache.write(key, resp, expires_in: CACHE_FOR, race_condition_ttl: RACE_CONDITION_TTL)
        elsif resp.status == 401
          session.delete("#{proxy_env}_public_user") # re-authorize
        end
        resp
      end
    else
      Faraday.new(opts).get(path)
    end
  end

  # session-cache the public proxy token
  def get_public_user
    if session["#{proxy_env}_public_user"].is_a?(Hash)
      Remote::User.new(session["#{proxy_env}_public_user"])
    else
      cfg = Rails.application.secrets.pmp_hosts[proxy_env]
      u = Remote::User.new(env: proxy_env, client_id: cfg['public_id'], client_secret: cfg['public_secret'])
      session["#{proxy_env}_public_user"] = u.as_json
      u
    end
  end

  # which env are we proxying
  def proxy_env
    params['proxy_env'] || 'production'
  end

end
