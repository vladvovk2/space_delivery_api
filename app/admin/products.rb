ActiveAdmin.register Product do
  permit_params :title, :image, :image_url
  filter :title
  filter :weight
  filter :price

  index do
    selectable_column
    id_column
    column :title
    column :category
    column :price
    column :weight
    column :image
    actions
  end

  show do
    attributes_table do
      row :title
      row :description
      row :image do |product_image|
        image_tag product_image.image.url if product_image
      end
    end
  end

  form(html: { multipart: true }) do |f|
    f.semantic_errors
    f.inputs 'Atributes' do
      f.input :title
    end
    f.inputs "Upload" do
      f.input :image, required: true, as: :file
    end
    f.actions
  end
end