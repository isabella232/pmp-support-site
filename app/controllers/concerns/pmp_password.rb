require 'active_support/concern'

module PmpPassword
  extend ActiveSupport::Concern

protected

  def invalid_password_msg(username, new_password)
    strength = PasswordStrength.test(username, new_password)
    if strength.valid?(:good)
      nil
    else
      'That password is weak!  Beef it up a bit, eh?'
    end
  end

end
