require 'rubygems'

ENV['RAILS_ENV'] = 'test'

require File.expand_path('../config/environment', __dir__)

require 'rspec/rails'
RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec

  config.color = true
  config.formatter = :documentation

  config.include Rack::Test::Methods
  config.include RSpec::Rails::RequestExampleGroup, type: :request, file_path: %r{spec/delivery_api}
end
