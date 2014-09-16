require 'active_support/concern'

#
# pmp user/session utilities
#
module PmpUser
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
    helper_method :current_users
    helper_method :current_pmp
    helper_method :current_auth
    rescue_from Faraday::ClientError, with: :logout_on_401
  end

  # config for the current user account
  def current_user
    session[:current_user] || nil
  end

  # config for all user accounts
  def current_users
    session[:users] || []
  end

  # pmp client with token auth
  def current_pmp
    if @current_pmp_user_key != current_user
      @current_pmp_user_key = current_user['key']
      @current_pmp_client = get_pmp_client(current_user, true)
    end
    @current_pmp_client
  end

  # pmp client with user auth
  def current_auth
    if @current_auth_user_key != current_user
      @current_auth_user_key = current_user['key']
      @current_auth_client = get_pmp_client(current_user)
    end
    @current_auth_client
  end

  # login a user
  def user_add(host, user, pass)
    config = {
      'key'    => get_pmp_key(host, user),
      'host'   => host,
      'user'   => user,
      'pass'   => pass,
      'id'     => nil,
      'secret' => nil,
    }
    pmp = get_pmp_client(config)
    all_clients = pmp.credentials.list.clients

    # find or create a client for the support-app to use
    client = all_clients.find { |c| c['label'] == 'pmp-support-app' }
    unless client
      client = pmp.credentials.create(scope: 'write', label: 'pmp-support-app')
    end
    config[:id] = client[:client_id]
    config[:secret] = client[:client_secret]

    # worked! return the user config
    session[:users] ||= []
    session[:users] << config
    session[:current_user] = config
  rescue Faraday::ClientError => e
    if e.response && e.response[:status] == 401
      false
    else
      raise e
    end
  end

  # find a user account by key or host+user
  def user_find(key_or_host, user = nil)
    key_or_host = get_pmp_key(key_or_host, user) if user
    (session[:users] || {}).find { |cfg| cfg['key'] == key_or_host }
  end

  # switch to a different user account
  def user_switch(user_key)
    if cfg = user_find(user_key)
      session[:current_user] = cfg
      true
    else
      false
    end
  end

  # update the current user
  def user_update(new_username = nil, new_password = nil)
    if new_username.present?
      current_user['user'] = new_username
      current_user['key'] = get_pmp_key(current_user['host'], new_username)
    end
    if new_password.present?
      current_user['pass'] = new_password
    end
  end

  # log out all accounts
  def user_destroy_all
    session[:users] = []
    session[:current_user] = nil
  end

protected

  # get a unique key for a host + user
  def get_pmp_key(host, user)
    if Rails.application.secrets.pmp_hosts[host]
      host = Rails.application.secrets.pmp_hosts[host]['host']
    end
    "#{user}@#{host.gsub(/^https?:\/\/|\/$/, '')}"
  end

  # get the api client for a user's config
  def get_pmp_client(config, use_bearer = false)
    pmp_cfg = {}
    if config['host'] && Rails.application.secrets.pmp_hosts[config['host']]
      pmp_cfg[:endpoint] = Rails.application.secrets.pmp_hosts[config['host']]['host']
      pmp_cfg[:endpoint] << '/' unless pmp_cfg[:endpoint].match(/\/$/) # TODO
    else
      pmp_cfg[:endpoint] = 'https://api-foobar.pmp.io'
    end

    # don't try to use both bearer and user creds
    if use_bearer
      pmp_cfg[:client_id]     = config['id']     || ''
      pmp_cfg[:client_secret] = config['secret'] || ''
    else
      pmp_cfg[:user]     = config['user'] || ''
      pmp_cfg[:password] = config['pass'] || ''
    end
    PMP::Client.new(pmp_cfg)
  end

  # catch global 401's
  def logout_on_401(e)
    if e.response && e.response[:status] == 401
      session[:users] = []
      session[:current_user] = nil
      redirect_to login_path, notice: 'Unauthorized! Please login again.'
    else
      raise e
    end
  end

end
