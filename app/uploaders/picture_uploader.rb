class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :large do
    process resize_to_fit: [200, 200]
  end

  version :medium do
    process resize_to_fit: [150, 150]
  end

  version :lmedium do
    process resize_to_fit: [100, 100]
  end

  version :small do
    process resize_to_fit: [50, 50]
  end

  def extension_white_list
    %w[jpg jpeg png]
  end

  def filename
    "#{Time.zone.today}.#{secure_token(16)}.#{file.extension}" if original_filename.present?
  end

  protected

  def secure_token(length = 16)
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.hex(length / 2))
  end
end
