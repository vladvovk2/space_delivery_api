ActiveAdmin.register Product do
  permit_params :title, :price, :weight, :description, :category_id, :image
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
      row :image do |product_image|
        image_tag product_image.image.url(:medium) if product_image.present?
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
      f.input :image, required: true, as: :file
    end
    f.actions
  end
end
