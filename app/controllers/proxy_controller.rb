class ProxyController < ApplicationController

  # GET /proxy/public/...
  def public_proxy
    resp = make_request(get_public_user)
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
  def make_request(remote_user)
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
    Faraday.new(opts).get(path)
  end

  # session-cache the public proxy token
  def get_public_user
    if session[:public_user].is_a?(Hash)
      Remote::User.new(session[:public_user])
    else
      cfg = Rails.application.secrets.pmp_hosts['production']
      u = Remote::User.new(env: 'production', client_id: cfg['public_id'], client_secret: cfg['public_secret'])
      session[:public_user] = u.as_json
      u
    end
  end

end
