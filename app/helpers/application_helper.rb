module ApplicationHelper

  # pmp api user
  def format_user(user)
    user[0] + ' @ ' + user[2].gsub(/^https?:\/\//, '')
  end

  # tab helper
  def active_tab(*path)
    path.include?(request.path) ? 'active' : ''
  end

end
