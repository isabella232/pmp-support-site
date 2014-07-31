class SessionsController < ApplicationController
  before_filter :require_login!, only: [:add_account, :do_add_account, :switch, :logout]
  before_filter :require_not_login!, except: [:add_account, :do_add_account, :switch, :logout]
  rescue_from ActionController::ParameterMissing, with: :show_errors
  rescue_from Faraday::ClientError, with: :show_invalid

  # GET /login
  def login
  end

  # GET /add_account
  def add_account
  end

  # GET /switch/1
  def switch
    if new_usr = session[:users][params[:id].to_i]
      session[:current_user] = new_usr
      redirect_to credentials_path, notice: "Switched to account #{view_context.format_user(new_usr)}"
    else
      redirect_to root_path, alert: 'Unknown account'
    end
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
    get_client.credentials.list
    (session[:users] ||= []) << make_user
    session[:current_user] = make_user
    redirect_to credentials_path, notice: 'You are now logged in'
  end

  # POST /add_account
  def do_add_account
    client = get_client
    if session[:users].find { |u| u[0] == make_user[0] && u[2] == make_user[2] }
      flash.now.alert = 'Already signed in to that account'
      render :add_account
    else
      get_client.credentials.list
      session[:users] << make_user
      session[:current_user] = make_user
      redirect_to credentials_path, notice: "Switched to account #{view_context.format_user(make_user)}"
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
    flash.now.alert = 'Please fill out all fields'
    render request.path.gsub('/', '')
  end

  # rescue 401's
  def show_invalid(err)
    if err.as_json['response']['status'] == 401
      flash.now.alert = 'Invalid username/password'
      render request.path.gsub('/', '')
    else
      raise err
    end
  end

  # get pmp client from parameters
  def get_client
    params[:session].require(:host)
    params[:session].require(:username)
    params[:session].require(:password)
    sp = params[:session] || {}
    PMP::Client.new(user: sp[:username], password: sp[:password], endpoint: sp[:host] + '/')
  end

  # assemble user array
  def make_user
    sp = params[:session] || {}
    [sp[:username], sp[:password], sp[:host]]
  end

end
