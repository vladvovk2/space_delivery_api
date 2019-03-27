source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.2'

# Gems which i've used for made WEB.
gem 'uglifier', '>= 1.3.0'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'jbuilder', '~> 2.5'
gem 'turbolinks', '~> 5'
gem 'sass-rails', '~> 5.0'
gem 'coffee-rails', '~> 4.2'

# Gems which i've used for made Grape API.
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

# Gems which i've used for made Authentication.
gem 'jwt'
gem 'bcrypt'

# Gem which i've used for made commands.
gem 'rectify'

# Gems which i've used for background works.
gem 'redis'
gem 'sidekiq'
gem 'sinatra', require: false
gem 'redis-namespace'

# Gems which i've used for clear code.
gem 'rubocop'
gem 'fasterer'
gem 'rubocop-rails_config'

# Gem which i've used for upload files.
gem 'fog-aws'
gem 'aws-sdk-s3', require: false
gem 'mini_magick', '~> 4.8'
gem 'carrierwave', '~> 1.0'

# Gem which i've used for send verify message to user sing_up.
gem 'twilio-ruby'

# Gem which i've used for admin panel.
gem 'devise'
gem 'activeadmin'

group :development, :test do
  gem 'pry'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'bullet'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'web-console', '>= 3.3.0'
  gem 'spring-watcher-listen', '~> 2.0.0'
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