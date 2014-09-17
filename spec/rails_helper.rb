ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'

# headless js testing
Capybara.javascript_driver = :poltergeist

# support files
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# pending migrations?
ActiveRecord::Migration.maintain_test_schema!

#
# helper for heavyweight rspecs
#
RSpec.configure do |config|

  # activerecord
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true

  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # allow skipping specs that require admin credentials
  config.before admin: true do
    if ENV['PMP_HOST'].blank?
      skip 'No PMP admin credentials set for ENV (no host given)'
    else
      name, cfg = Rails.application.secrets.pmp_hosts.find do |name, cfg|
        ENV['PMP_HOST'].gsub(/\/$/, '') == cfg['host'].gsub(/\/$/, '')
      end
      if cfg.blank? || cfg['client_id'].blank? || cfg['client_secret'].blank?
        skip "No PMP admin credentials set for ENV (#{ENV['PMP_HOST']})"
      end
    end
  end

end
