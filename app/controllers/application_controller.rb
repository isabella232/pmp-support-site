class ApplicationController < ActionController::Base
  include GoogleAnalytics
  include PmpAdmin
  include PmpUser
  include PmpUserFilters

  protect_from_forgery with: :exception
  before_action :set_mailer_host

protected

  # make sure the mailer knows where we are
  def set_mailer_host
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
end
