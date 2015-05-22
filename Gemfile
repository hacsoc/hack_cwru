source 'https://rubygems.org'

ruby '2.2.2'

# Rails authentication with email and password
gem 'clearance'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Use LESS stylesheets
gem 'less-rails'
# Use postgresql as the database for Active Record
gem 'pg'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# V8 JavaScript interpreter in Ruby
gem 'therubyracer'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# bootstrap that UI
gem 'twitter-bootstrap-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

group :development do
  # Auto-run feature tests on code changes
  gem 'guard-cucumber'
  # Auto-run specs on code changes
  gem 'guard-rspec'
end

group :test do
  # Tracks coverage over time
  gem 'coveralls', require: false
  # Cucumber features for rails
  gem 'cucumber-rails', require: false
  # Database cleaner for cucumber scenarios
  gem 'database_cleaner'
  # Set up test objects in factories
  gem 'factory_girl_rails', require: false
  # Fake test data generation
  gem 'forgery'
  # Helpful matchers for rails
  gem 'shoulda-matchers'
  # Simple test coverage tool
  gem 'simplecov'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Use RSpec for testing
  gem 'rspec-rails'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Use pry instead of IRB
  gem 'pry-rails'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~> 0.4.0'
end
