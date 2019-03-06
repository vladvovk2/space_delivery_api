class Picture < ApplicationRecord
  mount_uploader :image_name, PictureUploader

  belongs_to :imageable, polymorphic: true, optional: true
end
