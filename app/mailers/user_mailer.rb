class UserMailer < ActionMailer::Base
  default from: 'support@publicmediaplatform.org'

  def password_reset_email(password_reset)
    @password_reset = password_reset
    @token_link = reset_password_url(@password_reset.token)
    mail(to: @password_reset.email_address, subject: "Reset your #{@password_reset.host} password")
  end

  def registration_request(req)
    @request = req
    mail(to: 'support@publicmediaplatform.org', subject: "PMP registration request from #{req['name']}")
  end

end
