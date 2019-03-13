ActiveAdmin.register Product do
  menu priority: 4

  permit_params(:title,
                :description,
                :category_id,
                picture_attributes: %i[id image_name],
                product_types_attributes: %i[id proportion price weight _destroy])

  filter :title
  filter :category

  controller do
    def scoped_collection
      super.includes(:product_types, :category, :picture)
    end
  end

  index do
    id_column
    column :image do |product|
      image_tag product.picture.image_name.url(:small) if product.picture.image_name.present?
    end
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
      row :category
      row :description
      row :image do |product|
        image_tag product.picture.image_name.url(:medium) if product.picture.image_name.present?
      end
      panel 'Product types' do
        table_for product.product_types do
          column :proportion
          column(:price) { |type| number_to_currency(type.price) }
          column :weight
        end
      end
    end
  end

  form(html: { multipart: true }) do |f|
    f.semantic_errors
    f.inputs 'Product atributes' do
      f.input :title
      f.input :description
      f.input :category, as: :select, collection: Category.all
    end
    f.inputs 'Product type' do
      f.has_many :product_types, allow_destroy: true do |t|
        t.input :proportion, as: :select, collection: ProductType::PRODUCT_TYPE
        t.input :price
        t.input :weight
      end
    end
    f.inputs 'Upload image' do
      f.has_many :picture, as: :imageable do |i|
        i.input :image_name, require: true, as: :file
      end
    end
    f.actions
  end
end
