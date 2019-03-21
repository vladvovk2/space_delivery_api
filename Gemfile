source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails', '~> 5.2.2'
gem 'puma', '~> 3.11'

# Gems which iʼm used for made Grape API.
gem 'rack-cors'
gem 'grape'
gem 'grape-entity'
gem 'grape-swagger'
gem 'grape-swagger-rails'
gem 'grape-swagger-entity'
gem 'hashie-forbidden_attributes'

# DataBase gem.
gem 'pg'

# ENV gem.
gem 'dotenv-rails'

# Gems which iʼm used for made Authentication.
gem 'jwt'
gem 'bcrypt'

# Gem which iʼm used for made commands.
gem 'rectify'

# Gems which iʼm used for background works.
gem 'redis'
gem 'redis-namespace'
gem 'sidekiq'
gem 'sinatra', require: false

# Gems which iʼm used for clear code.
gem 'fasterer'
gem 'rubocop'
gem 'rubocop-rails_config'

# Gem which iʼm used for upload files.
gem 'fog-aws'
gem 'aws-sdk-s3', require: false
gem 'mini_magick', '~> 4.8'
gem 'carrierwave', '~> 1.0'

# Gem which iʼm used for send verify message to user sing_up.
gem 'twilio-ruby'

# Gem which iʼm used for admin panel.
gem 'activeadmin'
gem 'devise'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'bullet'
end

group :test do
  gem 'faker'
  gem 'rspec'
  gem 'rack-test'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'factory_bot_rails'

  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false