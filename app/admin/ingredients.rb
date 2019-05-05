ActiveAdmin.register Ingredient do
  permit_params(:title,
                :price,
                :ingredient_type,
                picture_attributes: %i[id image_name])

  controller do
    def scoped_collection
      super.includes(:picture)
    end
  end

  index do
    id_column
    column(:image) { |product| image_tag product.picture.image_name.url(:small) if product.picture.present? }
    column :title
    column :ingredient_type
    column :price
    actions
  end

  show do
    attributes_table do
      row :title
      row :ingredient_type
      row :price
      row(:image) { |product| image_tag product.picture.image_name.url(:medium) if product.picture.present? }
    end
  end

  form(html: { multipart: true }) do |f|
    f.semantic_errors
    f.inputs 'Product atributes' do
      f.input :title
      f.input :price
      f.input :ingredient_type, collection: Ingredient::INGREDIENT_TYPES
    end
    f.inputs 'Upload image' do
      f.has_many :picture, as: :imageable do |i|
        i.input :image_name, require: true, as: :file
      end
    end
    f.actions
  end
end
