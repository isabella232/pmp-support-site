require 'rails_helper'

RSpec.describe PasswordReset, type: :model do
  it { is_expected.to validate_presence_of :email_address }
  it { is_expected.to validate_presence_of :user_name }
  it { is_expected.to validate_presence_of :user_guid }
  it { is_expected.to validate_presence_of :host }

  describe '#generate_token' do
    it 'generates a token' do
      password_reset = PasswordReset.new

      expect {
        password_reset.generate_token
      }.to change { password_reset.token }
    end
  end

  describe '#send_reset_email!' do
    let(:mailer) { double(:mailer) }

    it 'sends a password_reset_email' do
      password_reset = PasswordReset.new

      allow(mailer).to receive(:deliver_now)

      expect(UserMailer).to receive(:password_reset_email).with(password_reset).and_return(mailer)

      password_reset.send_reset_email!
    end
  end

  describe '#host_url' do
    context 'when host exists on pmp_hosts list' do
      it 'returns host url' do
        password_reset = PasswordReset.new(host: 'sandbox')

        expect(password_reset.host_url).to eq "https://api-sandbox.pmp.io"
      end
    end

    context 'when host does not exists on pmp_hosts list' do
      it 'returns unknown' do
        password_reset = PasswordReset.new(host: 'some-host')

        expect(password_reset.host_url).to eq 'unknown'
      end
    end
  end

  describe '#host_title' do
    it 'returns the host url without the protocol' do
      password_reset = PasswordReset.new(host: 'sandbox')

      expect(password_reset.host_title).to eq 'api-sandbox.pmp.io'
    end
  end
end
