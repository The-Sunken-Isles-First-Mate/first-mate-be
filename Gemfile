source 'https://rubygems.org'
git_source(:github) { |repo| 'https://github.com/#{repo}.git' }

ruby '3.2.2'

gem 'bootsnap', require: false
gem 'faraday'
gem 'importmap-rails'
gem 'rails', '~> 7.1.2'
gem 'jbuilder'
gem 'pg', '~> 1.1'
gem 'puma', '~> 6.0'
gem 'redis', '~> 4.0'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem 'capybara'
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'launchy'
  gem 'orderly'
  gem 'pry'
  gem 'rspec-rails'
  gem 'simplecov'
  gem 'shoulda-matchers'
  gem 'vcr'
  gem 'webmock'
end

group :test do; end

group :development do
  gem 'web-console'
end