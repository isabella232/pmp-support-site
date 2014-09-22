require 'active_support/concern'

#
# pmp user/session utilities
#
module PmpUser
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
    helper_method :current_users
    rescue_from Faraday::ClientError, with: :logout_on_401
  end

  # the current remote user
  def current_user
    if session[:user_key]
      if !@current_remote_usr || @current_remote_usr.key != session[:user_key]
        @current_remote_usr = user_find(session[:user_key])
      end
    end
    @current_remote_usr
  end

  # all known remote users
  def current_users
    @current_remote_usrs ||= []
    if session[:users].is_a?(Array) && @current_remote_usrs.count != session[:users].count
      @current_remote_usrs = session[:users].map { |cfg| Remote::User.new(cfg) }
    end
    @current_remote_usrs
  end

  # login a user
  def user_add(env, user, pass)
    u = Remote::User.new(env: env, username: user, password: pass)
    session[:users] ||= []
    session[:users] << u.as_json
    session[:user_key] = u.key
  rescue Faraday::ClientError => e
    if e.response && e.response[:status] == 401
      false
    else
      raise e
    end
  end

  # find a user account by key or host+user
  def user_find(key_or_env, user = nil)
    current_users.find do |u|
      u.key == key_or_env || (key_or_env == u.env && u.username == user)
    end
  end

  # switch to a different user account
  def user_switch(user_key)
    if u = user_find(user_key)
      session[:user_key] = u.key
      true
    else
      false
    end
  end

  # update the current user
  def user_update(new_username = nil, new_password = nil)
    new_cfg = current_user.as_json
    new_cfg[:username] = new_username if new_username.present?
    new_cfg[:password] = new_password if new_password.present?
    u = Remote::User.new(new_cfg)
    session[:users] = session[:users].map do |cfg|
      if cfg.with_indifferent_access[:key] == current_user.key
        new_cfg = u.as_json
      else
        cfg
      end
    end
    session[:user_key] = u.key

    # break cache
    @current_remote_usr = nil
    @current_remote_usrs = nil
  end

  # log out all accounts
  def user_destroy_all
    reset_session
    @current_remote_usr = nil
    @current_remote_usrs = nil
  end

private

  # catch global 401's
  def logout_on_401(e)
    if e.response && e.response[:status] == 401
      session[:users] = []
      session[:user_key] = nil
      @current_remote_usr = nil
      @current_remote_usrs = nil
      redirect_to login_path, notice: 'Unauthorized! Please login again.'
    else
      raise e
    end
  end

end
