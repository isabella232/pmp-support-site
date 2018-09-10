require "rails_helper"

describe UserMailer, type: :mailer do
  describe '#password_reset_email' do
    let(:password_reset) do
      PasswordReset.new(
        host: 'sandbox',
        token: 'some-token',
        email_address: 'email@email.com',
        user_name: 'johndoe'
      )
    end

    let(:mail) { described_class.password_reset_email(password_reset) }

    it 'sends the email to the correct address' do
      expect(mail.to).to eq([password_reset.email_address])
    end

    it 'uses the correct subject' do
      expect(mail.subject).to eq('Reset your api-sandbox.pmp.io password')
    end

    it 'contains the user name and host for the password reset' do
      expect(mail.body).to include(
        'We received a request for user <strong>johndoe</strong> at <strong>api-sandbox.pmp.io</strong>.'
      )
    end
  end

  describe '#registration_request' do
    let(:request) do
      {
        'host' => 'sandbox',
        'name' => 'request name',
        'email' => 'request email',
        'organization' => 'request organization',
        'cms' => 'request cms',
        'intention' => 'request intention'
      }
    end

    let(:mail) { described_class.registration_request(request) }

    it 'sends the email to the correct address' do
      expect(mail.to).to eq(['support@publicmediaplatform.org'])
    end

    it 'uses the correct subject' do
      expect(mail.subject).to eq("PMP registration request from #{request['name']}")
    end

    it 'contains the user name and host for the password reset' do
      expect(mail.body).to include(request['host']) &
        include(request['name']) &
        include(request['email']) &
        include(request['organization']) &
        include(request['cms']) &
        include(request['intention'])
    end
  end
end
