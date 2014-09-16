require 'active_support/concern'

#
# before filters for pmp users
#
module PmpUserFilters
  extend ActiveSupport::Concern

protected

  # force login
  def require_login!
    if current_user
      if session[:last_seen_at] && session[:last_seen_at] < 24.hours.ago
        session[:last_seen_at] = nil
        session[:users] = nil
        session[:current_user] = nil
        ga_event!('sessions', 'timeout')
        redirect_to login_path, notice: 'Your session has expired - please login'
      else
        session[:last_seen_at] = Time.now
      end
    else
      redirect_to login_path, notice: 'You must login first'
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
