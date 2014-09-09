#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
#
RSpec.configure do |config|

  # output type
  config.default_formatter = 'doc'

  # slow specs
  # config.profile_examples = 10

  # randomize
  config.order = :random

  # either syntax is okay
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

end
