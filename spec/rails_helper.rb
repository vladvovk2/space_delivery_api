require 'rails/all'
require 'rspec/rails'
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

abort('The Rails environment is running in production mode!') unless Rails.env.test?

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include HelpersRspec
  config.include Rack::Test::Methods
  config.include FactoryBot::Syntax::Methods
  config.include RSpec::Rails::RequestExampleGroup, type: :request, file_path: %r{spec/delivery_api}
end
