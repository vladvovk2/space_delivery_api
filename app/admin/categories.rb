ActiveAdmin.register Category do
  permit_params :title, :image
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
      row :image do |category_image|
        image_tag category_image.image.url(:medium) if category_image.present?
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
