class RegisterController < ApplicationController

  before_filter :setup_negative_captcha
  before_filter :require_not_login!

  # GET /register
  def new
  end

  # POST /register
  def create
    if @captcha.valid?
      if %w(name email organization username intention).all? { |k| @captcha.values[k].present? }
        UserMailer.registration_request(@captcha.values).deliver
        ga_event!('registrations', 'create')
        redirect_to :login, notice: 'Thank you - your request has been sent.  You should hear back from us within 24 hours.'
      else
        flash.now.alert = 'Please fill out all fields'
        render :new
      end
    else
      flash.now.alert = @captcha.error
      render :new
    end
  end

protected

  # negative-captcha gem
  def setup_negative_captcha
    @captcha = NegativeCaptcha.new(
      secret:  Rails.application.secrets.secret_key_base,
      spinner: request.remote_ip,
      fields: [:host, :name, :email, :organization, :username, :intention],
      params: params
    )
  end

end
