class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

protected

  # memoize user
  def current_user
    session[:current_user] || nil
  end
  helper_method :current_user

  # all users
  def current_users
    session[:users] || []
  end
  helper_method :current_users

  # memoize pmp
  def current_pmp
    if @current_user != current_user
      @current_user = nil
      @pmp = nil
    end
    if cu = current_user
      @current_user = cu
      @pmp ||= PMP::Client.new(user: cu[0], password: cu[1], endpoint: cu[2] + '/')
    else
      @pmp = nil
    end
  end
  helper_method :current_pmp

  # force login
  def require_login!
    unless current_user
      flash[:notice] = 'You must login first'
      redirect_to login_path
    end
  end

  # force unlogin
  def require_not_login!
    if current_user
      flash[:notice] = 'You are already logged in'
      redirect_to root_path
    end
  end

end
