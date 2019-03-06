ActiveAdmin.register Product do
  permit_params :title,
                :price,
                :weight,
                :description,
                :category_id,
                picture_attributes: :image_name

  filter :title
  filter :weight
  filter :price
  filter :category

  index do
    selectable_column
    id_column
    column :title
    column :category
    column :price
    column :weight
    actions
  end

  show do
    attributes_table do
      row :title
      row :description
      row :image do |product|
        image_tag product.picture.image_name.url(:medium)
      end
    end
  end

  form(html: { multipart: true }) do |f|
    f.semantic_errors
    f.inputs 'Atributes' do
      f.input :title
      f.input :description
      f.input :price
      f.input :weight
      f.input :category, as: :select, collection: Category.all
    end
    f.inputs 'Upload' do
      f.has_many :picture, as: :imageable do |b|
        b.input :image_name, required: true, as: :file
      end
    end
    f.actions
  end
end