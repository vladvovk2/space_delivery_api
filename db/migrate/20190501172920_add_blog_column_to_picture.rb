class AddBlogColumnToPicture < ActiveRecord::Migration[5.2]
  def change
    add_column :pictures, :blog_image, :string
  end
end
