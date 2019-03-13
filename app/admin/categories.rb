ActiveAdmin.register Category do
  menu priority: 5

  permit_params :title, picture_attributes: :image_name
  filter :title

  index do
    selectable_column
    id_column
    column :title
    actions
  end

  show do
    attributes_table do
      row :title
      row :image do |category|
        image_tag category.picture.image_name.url(:medium) if category.picture.image_name.present?
      end
    end
  end

  form(html: { multipart: true }) do |f|
    f.semantic_errors
    f.inputs 'Atributes' do
      f.input :title
    end
    f.inputs 'Upload image' do
      f.has_many :picture, as: :imageable do |i|
        i.input :image_name, require: true, as: :file
      end
    end
    f.actions
  end
end
