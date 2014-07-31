module ApplicationHelper

  def format_user(user)
    user[0] + ' @ ' + user[2].gsub(/^https?:\/\//, '')
  end

end
