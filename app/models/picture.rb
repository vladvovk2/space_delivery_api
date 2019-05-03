class Picture < ApplicationRecord
  mount_uploader :image_name, PictureUploader
  mount_uploader :blog_image, BlogPictureUploader
  belongs_to :imageable, polymorphic: true, optional: true
end
