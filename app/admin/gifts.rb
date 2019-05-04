ActiveAdmin.register Gift do
  menu priority: 7
  actions :all, except: :show

  permit_params :amount_target,
                :limitation,
                :product_id,
                :gift_type,
                :quantity

  index do
    id_column
    column(:product, &:product)
    column :amount_target
    column :limitation
    column :created_at
    actions
  end

  form(html: { multipart: true }) do |f|
    f.semantic_errors
    f.inputs 'Atributes' do
      f.input :gift_type, collection: Gift::GIFT_TYPES
      f.input :amount_target
      f.input :quantity
      f.input :limitation
      f.input :product, as: :select, collection: Product.where(published: true)
    end
    f.actions
  end
end
