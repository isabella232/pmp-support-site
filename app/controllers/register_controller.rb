class RegisterController < ApplicationController

  before_action :setup_negative_captcha
  before_action :require_not_login!

  # GET /register
  def new
  end

  # POST /register
  def create
    if @captcha.valid?
      if %w(name email organization intention).all? { |k| @captcha.values[k].present? }
        UserMailer.registration_request(register_params).deliver
        ga_event!('registrations', 'create')
        redirect_to :login, notice: 'Thank you - your request has been sent.  You should hear back from us within 48 hours.'
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
      fields: [:name, :email, :organization, :intention],
      params: params
    )
  end

  # all params (negative captcha and normal)
  def register_params
    params.permit(:host, cms: []).merge(@captcha.values)
  end

end
