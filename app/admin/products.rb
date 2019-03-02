ActiveAdmin.register Product do
  permit_params :title, :image
  filter :title
  filter :weight
  filter :price

  index do
    id_column
    column :title
    column :category
    column :price
    column :weight
    column :image
  end

  form do |f|
    f.inputs 'Atributes' do
      f.input :title
    end
    f.inputs "Upload" do
      f.input :image, required: true, as: :file
    end
    f.actions
  end
end