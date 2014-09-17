class PasswordReset < ActiveRecord::Base
  before_validation :generate_token
  after_create :send_reset_email!

  validates :token, presence: true, uniqueness: true
  validates :email_address, presence: true
  validates :user_name, presence: true
  validates :user_guid, presence: true
  validates :host, presence: true

  def generate_token
    self.token ||= SecureRandom.urlsafe_base64
  end

  def send_reset_email!
    UserMailer.password_reset_email(self).deliver
  end

  def host_url
    if Rails.application.secrets.pmp_hosts[self.host]
      Rails.application.secrets.pmp_hosts[self.host]['host']
    else
      'unknown'
    end
  end

  def host_title
    self.host_url.gsub(/^https?:\/\/|\/$/, '')
  end

end
