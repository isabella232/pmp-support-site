class CredentialsController < ApplicationController
  before_filter :require_login!

  # GET /credentials
  def index
    @clients = current_pmp.credentials.list.clients
  end

  # POST /credentials
  def create
    client_params = params.slice(:scope, :label, :token_expires_in)
    cred = current_pmp.credentials.create(client_params)
    ga_event!('credentials', 'create')
    redirect_to credentials_path, notice: "Created client #{cred[:client_id]}"
  rescue Faraday::ClientError => e
    ga_event!('credentials', 'failure')
    redirect_to credentials_path, alert: "Unable to create client: #{e}"
  end

  # DELETE /credentials/1
  def destroy
    current_pmp.credentials.destroy(params[:id])
    ga_event!('credentials', 'destroy')
    redirect_to credentials_path, notice: "Deleted client #{params[:id]}"
  rescue Faraday::ClientError => e
    ga_event!('credentials', 'failure')
    redirect_to credentials_path, alert: "Unable to delete client: #{e}"
  end

end
