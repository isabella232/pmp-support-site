class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :set_mailer_host

protected

  # make sure the mailer knows where we are
  def set_mailer_host
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

  # admin interface to the API
  def admin_pmp(hostname)
    @admin_pmps ||= {}
    key, cfg = Rails.application.secrets.pmp_hosts.find { |k, c| c['host'] == hostname }
    @admin_pmps[key] ||= PMP::Client.new(client_id: cfg['client_id'], client_secret: cfg['client_secret'], endpoint: cfg['host'])
    @admin_pmps[key]
  end

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
