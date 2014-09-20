require 'active_support/concern'

#
# before filters for pmp users
#
module PmpUserFilters
  extend ActiveSupport::Concern

  SESSION_TIMEOUT = 24.hours

  included do
    before_filter :check_last_seen_at
  end

protected

  # record every time user is seen
  def check_last_seen_at
    if session[:last_seen_at] && session[:last_seen_at].to_i < SESSION_TIMEOUT.ago.to_i
      session[:last_seen_at] = nil
      user_destroy_all
      @user_session_expired = true
    else
      session[:last_seen_at] = Time.now.to_i
      @user_session_expired = false
    end
  end

  # force login
  def require_login!
    unless current_user
      if @user_session_expired
        redirect_to login_path, notice: 'Your session has expired - please login'
      else
        redirect_to login_path, notice: 'You must login first'
      end
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
