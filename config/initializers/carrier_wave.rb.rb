require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.production?
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:             'AWS',
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region:                ENV['AWS_REGION'],
    }

    config.fog_directory = ENV['AWS_BUCKET']
    config.storage       = :fog
    config.fog_public    = true
  else
    config.storage = :file
    config.enable_processing = Rails.env.development?
  end
end