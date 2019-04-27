ActiveAdmin.register Gift do
  menu priority: 7
  actions :all, except: %i[edit destroy]

  permit_params :amount_target, :limitation, :product_id

  index do
    id_column
    column(:product, &:product)
    column :amount_target
    column :limitation
    column :created_at
  end

  form(html: { multipart: true }) do |f|
    f.semantic_errors
    f.inputs 'Atributes' do
      f.input :amount_target
      f.input :limitation
      f.input :product, as: :select, collection: Product.where(published: true)
    end
    f.actions
  end
end
