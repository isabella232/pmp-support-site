require 'active_support/concern'

module PmpAdmin
  extend ActiveSupport::Concern

  # admin interface to the API
  def admin_pmp(env)
    @admin_pmp_roots ||= {}
    unless @admin_pmp_roots[env]
      cfg = Rails.application.secrets.pmp_hosts.with_indifferent_access[env]
      u = Remote::User.new(env: env, client_id: cfg['client_id'], client_secret: cfg['client_secret'])

      # memoize the pmp client
      @admin_pmp_roots[env] = u.pmp_client
    end
    @admin_pmp_roots[env]
  end

end
