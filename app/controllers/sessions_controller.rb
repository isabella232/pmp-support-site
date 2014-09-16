class SessionsController < ApplicationController

  before_filter :setup_negative_captcha
  before_filter :require_login!,     only:   [:add_account, :do_add_account, :switch, :logout]
  before_filter :require_not_login!, except: [:add_account, :do_add_account, :switch, :logout]

  # GET /login
  def login
  end

  # GET /add_account
  def add_account
  end

  # GET /switch/username@host
  def switch
    if user_switch(params[:key])
      ga_event!('sessions', 'switch')
      redirect_to credentials_path, notice: "Switched to account #{current_user['key']}"
    else
      redirect_to root_path, alert: 'Unknown account'
    end
  end

  # GET /logout
  def logout
    user_destroy_all
    ga_event!('sessions', 'logout')
    redirect_to login_path, notice: 'You have been logged out'
  end

  # POST /login
  def do_login
    if negative_captcha_validated?
      host, user, pass = @captcha.values.slice('host', 'username', 'password').values
      if user_add(host, user, pass)
        ga_event!('sessions', 'login')
        redirect_to credentials_path, notice: 'You are now logged in'
      else
        ga_event!('sessions', 'invalid')
        flash.now.alert = 'Invalid username/password'
        render :login
      end
    else
      render :login
    end
  end

  # POST /add_account
  def do_add_account
    if negative_captcha_validated?
      host, user, pass = @captcha.values.slice('host', 'username', 'password').values
      if user_find(host, user)
        flash.now.alert = 'Already signed in to that account'
        render :add_account
      elsif user_add(host, user, pass)
        ga_event!('sessions', 'add_account')
        redirect_to credentials_path, notice: "Switched to account #{current_user['key']}"
      else
        ga_event!('sessions', 'invalid')
        flash.now.alert = 'Invalid username/password'
        render :add_account
      end
    else
      render :add_account
    end
  end

protected

  # negative-captcha gem
  def setup_negative_captcha
    @captcha = NegativeCaptcha.new(
      secret:  Rails.application.secrets.secret_key_base,
      spinner: request.remote_ip,
      fields: [:host, :username, :password],
      params: params
    )
  end

  # make sure params look okay
  def negative_captcha_validated?
    if !@captcha.valid?
      flash.now.alert = @captcha.error
      false
    elsif !%w(host username password).all? { |k| @captcha.values[k].present? }
      flash.now.alert = 'Please fill out all fields'
      false
    elsif !Rails.application.secrets.pmp_hosts.keys.include?(@captcha.values['host'])
      flash.now.alert = 'Invalid host'
      false
    else
      true
    end
  end

end
