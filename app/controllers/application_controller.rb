class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :require_login!, unless: :current_user



protected

  # memoize user
  def current_user
    if session[:current_user]
      @current_user ||= session[:users].find { |u| u[0] == session[:current_user] }
    else
      @current_user = nil
    end
  end
  helper_method :current_user

  # all users
  def current_users
    session[:users] || []
  end
  helper_method :current_users

  # memoize pmp
  def current_pmp
    if cu = current_user
      @pmp ||= PMP::Client.new(user: cu[0], password: cu[1], endpoint: cu[2] + '/')
    else
      @pmp = nil
    end
  end
  helper_method :current_pmp

  # force login
  def require_login!
    flash[:notice] = 'You must login first'
    redirect_to login_path
  end

end
