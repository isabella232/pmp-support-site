#
# ensure we have the correct secrets.yml env
#
RSpec.configure do |config|

  # skip specs requiring admin creds
  config.before admin: true do
    if ENV['PMP_HOST'].blank?
      skip 'No PMP admin credentials set for ENV (no host given)'
    else
      name, cfg = Rails.application.secrets.pmp_hosts.with_indifferent_access.find do |name, cfg|
        ENV['PMP_HOST'].gsub(/\/$/, '') == cfg['host'].gsub(/\/$/, '')
      end
      if cfg.blank? || cfg['client_id'].blank? || cfg['client_secret'].blank?
        skip "No PMP admin credentials set for ENV (#{ENV['PMP_HOST']})"
      end
    end
  end

  # skip specs requiring public creds (on production only)
  config.before public_proxy: true do
    cfg = Rails.application.secrets.pmp_hosts.with_indifferent_access['production']
    if cfg['public_id'].blank? || cfg['public_secret'].blank?
      skip 'No PMP public credentials set'
    end
  end

end
