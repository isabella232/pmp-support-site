module ApplicationHelper

  # tab helper
  def active_tab(*path)
    path.include?(request.path) ? 'active' : ''
  end

end
