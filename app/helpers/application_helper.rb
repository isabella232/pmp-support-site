module ApplicationHelper

  # tab helper
  def active_tab(*path)
    path.include?(request.path) ? 'active' : ''
  end

  # get full hostname
  def full_host(user)
    name = user['host']
    if Rails.application.secrets.pmp_hosts[name]
      Rails.application.secrets.pmp_hosts[name]['host']
    else
      name
    end
  end

  # find a contact email in a cdoc
  def doc_email(doc)
    if doc.emails.present?
      eml = doc.emails.find { |e| e['type'] == 'primary' } || doc.emails.first
      eml['email']
    else
      doc.email
    end
  end

  # human readable profile type
  def doc_type(doc)
    if doc.profile.present?
      str = doc.profile.first.href.split('/').last
      if str.present?
        str
      else
        '(unknown)'
      end
    else
      '(unknown)'
    end
  end

  # attempt to format a datetime
  def format_time(date)
    time_ago_in_words(date) + ' ago'
  rescue
    '(unknown)'
  end

end
