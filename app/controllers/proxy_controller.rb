class ProxyController < ApplicationController

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
      Rails.cache.fetch key, expires_in: 5.minutes, race_condition_ttl: 20.seconds do
        Faraday.new(opts).get(path)
      end
    else
      Faraday.new(opts).get(path)
    end
  end

  # session-cache the public proxy token
  def get_public_user
    proxy_env = params['proxy_env'] || 'production'
    if session["#{proxy_env}_public_user"].is_a?(Hash)
      Remote::User.new(session["#{proxy_env}_public_user"])
    else
      cfg = Rails.application.secrets.pmp_hosts[proxy_env]
      logger.debug("pmp:hosts[#{proxy_env}]: #{cfg.inspect}")
      u = Remote::User.new(env: proxy_env, client_id: cfg['public_id'], client_secret: cfg['public_secret'])
      session["#{proxy_env}_public_user"] = u.as_json
      u
    end
  end

end
