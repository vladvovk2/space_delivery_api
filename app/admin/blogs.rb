ActiveAdmin.register Blog do
  permit_params(:title,
                :description,
                picture_attributes: %i[id blog_image])

  filter :title

  controller do
    def scoped_collection
      super.includes(:picture)
    end
  end

  index do
    id_column
    column :image do |blog|
      image_tag blog.picture.blog_image.url(:small) if blog.picture.present?
    end
    column :title
    actions
  end

  show do
    attributes_table do
      row :title
      row :image do |blog|
        image_tag blog.picture.blog_image.url(:medium) if blog.picture.present?
      end
      row :description
    end
  end

  form(html: { multipart: true }) do |f|
    f.semantic_errors
    f.inputs 'Atributes' do
      f.input :title
      f.input :description
    end
    f.inputs 'Upload image' do
      f.has_many :picture, as: :imageable do |i|
        i.input :blog_image, require: true, as: :file
      end
    end
    f.actions
  end
end
