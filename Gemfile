source 'https://rubygems.org'

ruby '2.3.0'

gem 'rails', '>= 4.2.11'
gem 'therubyracer',  platforms: :ruby
gem 'turbolinks', '~> 2.5.3'
gem 'negative_captcha'
gem 'password_strength'
gem 'pmp', '>= 0.5.3', require: true
gem 'whenever', require: false

gem 'haml'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails', '~> 3.1.3'
gem 'handlebars_assets'
gem 'font-awesome-rails'
gem 'rest-client', '~> 2.0.0'
gem 'redcarpet'
gem 'rouge'
gem 'sprockets', '~> 2.12.5'
gem 'dotenv-rails'

gem 'rack-cors', :require => 'rack/cors'
gem 'rack', '>= 1.6.11'
gem 'loofah', '>= 2.2.3'
gem 'excon', '~> 0.71.0'

group :test, :development do
  gem 'pry', require: true
  gem 'spring'
  gem 'letter_opener'
  gem 'quiet_assets'
  gem 'sqlite3'
  gem 'rspec-rails', '~> 3.5.0'
  gem 'capybara'
  gem 'poltergeist', '~> 1.18.0'
  gem 'rake'
  gem 'simplecov', require: false
  gem 'shoulda-matchers', '~> 3.1'
end

group :production do
  gem 'pg'
  gem 'unicorn'
end
