ActiveAdmin.register Product do
  menu priority: 4

  permit_params :title,
                :description,
                :category_id,
                picture_attributes: :image_name,
                product_types_attributes: %i[proportion price weight]

  filter :title
  filter :weight
  filter :price
  filter :category

  index do
    selectable_column
    id_column
    column :title
    column :category
    column :type do |product|
      product.product_types.first.proportion
    end
    column :price do |product|
      product.product_types.first.price
    end
    column :weight do |product|
      product.product_types.first.weight
    end
    actions
  end

  show do
    attributes_table do
      row :title
      row :description
      row :image do |product|
        image_tag product.picture.image_name.url(:medium) unless product.picture.nil?
      end
    end
  end

  form(html: { multipart: true }) do |f|
    f.semantic_errors
    f.inputs 'Atributes' do
      f.input :title
      f.input :description
      f.input :category, as: :select, collection: Category.all
    end
    f.inputs 'Product type' do
      f.has_many :product_types do |b|
        b.input :proportion, as: :select, collection: ProductType::PRODUCT_TYPE
        b.input :price
        b.input :weight
      end
    end
    f.inputs 'Upload' do
      f.has_many :picture, as: :imageable do |b|
        b.input :image_name, required: true, as: :file
      end
    end
    f.actions
  end
end
