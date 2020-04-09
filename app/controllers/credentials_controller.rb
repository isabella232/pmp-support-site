class CredentialsController < ApplicationController
  before_action :require_login!

  # GET /credentials
  def index
    @clients = current_user.auth_client.credentials.list.clients
    @my_client_label = Remote::User::SUPPORT_CLIENT_LABEL
  end

  # POST /credentials
  def create
    cred = current_user.auth_client.credentials.create(client_params)
    ga_event!('credentials', 'create')
    redirect_to credentials_path, notice: "Created client #{cred[:client_id]}"
  rescue Faraday::ClientError => e
    ga_event!('credentials', 'failure')
    redirect_to credentials_path, alert: "Unable to create client: #{e}"
  end

  # DELETE /credentials/1
  def destroy
    current_user.auth_client.credentials.destroy(params[:id])
    ga_event!('credentials', 'destroy')
    redirect_to credentials_path, notice: "Deleted client #{params[:id]}"
  rescue Faraday::ClientError => e
    ga_event!('credentials', 'failure')
    redirect_to credentials_path, alert: "Unable to delete client: #{e}"
  end

  private

  def client_params
    params.permit(:scope, :label, :token_expires_in)
  end

end
