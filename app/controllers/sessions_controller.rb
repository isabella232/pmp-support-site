class SessionsController < ApplicationController
  before_filter :require_login!, only: :logout
  before_filter :require_not_login!, except: :logout
  rescue_from ActionController::ParameterMissing, with: :show_errors

  # GET /login
  def login
  end

  # GET /register
  def register
  end

  # GET /forgot
  def forgot_password
  end

  # GET /logout
  def logout
    session[:users] = nil
    session[:current_user] = nil
    redirect_to login_path, notice: 'You have been logged out'
  end

  # POST /login
  def do_login
    params.require(:host)
    params.require(:username)
    params.require(:password)
    pmp = PMP::Client.new(user: params[:username], password: params[:password], endpoint: params[:host] + '/')

    begin
      pmp.credentials.list
      (session[:users] ||= []) << [params[:username], params[:password], params[:host]]
      session[:current_user] = params[:username]
      redirect_to root_path
    rescue Faraday::ClientError => err
      if err.as_json['response']['status'] == 401
        flash.alert = 'Invalid username/password'
        render :login
      else
        raise err
      end
    end

  end

  # POST /register
  def do_register
  end

  # POST /forgot
  def do_forgot_password
  end

protected

  # flash errors
  def show_errors(err)
    flash.alert = 'Please fill out all fields'
    case request.path
    when '/login'
      render :login
    when '/register'
      render :register
    when '/forgot'
      render :forgot_password
    end
  end

end
