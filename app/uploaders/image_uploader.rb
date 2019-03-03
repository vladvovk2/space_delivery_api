class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process resize_to_fit: [50, 50]
  end

  version :small do
    process resize_to_fit: [150, 150]
  end

  version :medium do
    process resize_to_fit: [200, 200]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end