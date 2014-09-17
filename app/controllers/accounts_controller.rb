class AccountsController < ApplicationController
  include PmpPassword

  EMAIL_REGEX = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/

  # GET /account
  def show
    @me = my_user_doc
    @me.guid # trigger load
  end

  # PUT /account
  def update
    @me = my_user_doc
    @me.guid # trigger load
    update_doc(@me, account_params)
    if msg = invalid_params_msg
      flash.now.alert = msg
      render :show
    else
      @me.save
      user_update(account_params[:username], account_params[:password])
      redirect_to account_path, notice: 'Your account has been updated'
    end
  rescue Faraday::ClientError => e
    if e.response && e.response[:status] == 409
      flash.now.alert = 'Username is already taken! Try another one.'
      render :show
    else
      raise e
    end
  end

protected

  # fetch user cdoc
  def my_user_doc
    current_pmp.query['urn:collectiondoc:hreftpl:users'].where(guid: 'me').retrieve
  end

  # require / slice params
  def account_params
    params.permit(:username, :email, :title, :type, :password)
  end

  # set and validate
  def invalid_params_msg
    %w(username email title type).each { |k| params.require(k) }
    if account_params[:username].length < 3
      'Username is too short - must be at least 3 characters'
    elsif !account_params[:email].match(EMAIL_REGEX)
      'Invalid email address'
    elsif account_params[:title].length < 5
      'Title is too short - must be at least 5 characters'
    elsif !%(user organization).include?(account_params[:type])
      'Invalid user type - must be "user" or "organization"'
    elsif account_params[:password].present? && msg = invalid_password_msg(account_params[:username], account_params[:password])
      msg
    else
      nil
    end
  rescue ActionController::ParameterMissing => e
    "#{e.param.capitalize} is required!"
  end

  # update the cdoc without saving
  def update_doc(doc, data)
    doc.attributes[:auth][:user] = data[:username]
    doc.attributes[:title] = data[:title]

    # update emails, removing deprecated attributes.email
    doc.attributes.delete_field(:email) if doc.attributes.email
    doc.attributes[:emails] ||= []
    if eml = doc.attributes[:emails].find { |e| e[:type] == 'primary' }
      eml[:email] = data[:email]
    else
      doc.attributes[:emails] << {type: 'primary', email: data[:email]}
    end

    # update profile link
    prof_href = doc.query['urn:collectiondoc:hreftpl:profiles'].where(guid: data[:type]).url
    doc.links[:profile].first.href = prof_href

    # optionally set password
    if data[:password].present?
      doc.attributes[:auth][:password] = data[:password]
    end
  end

end
