ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)

require 'simplecov'
unless ENV['COVERAGE'] == 'false'
  SimpleCov.start do
    add_filter 'spec/'
  end
end

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

end
