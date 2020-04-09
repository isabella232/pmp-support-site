class SessionsController < ApplicationController

  before_action :require_login!,     only:   [:add_account, :do_add_account, :switch, :logout]
  before_action :require_not_login!, except: [:add_account, :do_add_account, :switch, :logout]

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
      redirect_to credentials_path, notice: "Switched to account #{current_user.key}"
    else
      redirect_to root_path, alert: 'Unknown account'
    end
  end

  # GET /logout
  def logout
    user_destroy_all(params[:revoke] ? true : false)
    ga_event!('sessions', 'logout')
    redirect_to login_path, notice: 'You have been logged out'
  end

  # POST /login
  def do_login
    if user_params_validated?
      host, user, pass = params.slice('host', 'username', 'password').values
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
    if user_params_validated?
      host, user, pass = params.slice('host', 'username', 'password').values
      if user_find(host, user)
        flash.now.alert = 'Already signed in to that account'
        render :add_account
      elsif user_add(host, user, pass)
        ga_event!('sessions', 'add_account')
        redirect_to credentials_path, notice: "Switched to account #{current_user.key}"
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

  # make sure params look okay
  def user_params_validated?
    if !%w(host username password).all? { |k| params[k].present? }
      flash.now.alert = 'Please fill out all fields'
      false
    elsif !Rails.application.secrets.pmp_hosts.with_indifferent_access.keys.include?(params['host'])
      flash.now.alert = 'Invalid host'
      false
    else
      true
    end
  end

end
