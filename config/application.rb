require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module KrylaApi
  class Application < Rails::Application
    config.load_defaults 5.2
    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]
    config.autoload_paths << Rails.root.join('lib')

    config.active_job.queue_adapter = :sidekiq
  end
end
