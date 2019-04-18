ActiveAdmin.register Product do
  menu priority: 4
  before_action :set_product, only: %i[publish unpublish]
  permit_params(:title,
                :description,
                :category_id,
                picture_attributes: %i[id image_name],
                product_types_attributes: %i[id proportion price weight _destroy])

  scope :all
  scope :published
  scope :unpublished

  filter :title
  filter :category

  action_item :publish, only: :show do
    link_to 'Publish', publish_admin_product_path, method: :put unless published?
  end

  action_item :unpublish, only: :show do
    link_to 'Unpublish', unpublish_admin_product_path, method: :put if published?
  end

  member_action :publish, method: :put do
    @product.update(published: true)
    redirect_to admin_product_path(@product)
  end

  member_action :unpublish, method: :put do
    @product.update(published: false)
    redirect_to admin_product_path(@product)
  end

  controller do
    include ActiveAdmin::ProductsHelper
    helper_method :published?

    def scoped_collection
      super.includes(:product_types, :category, :picture)
    end

    def published?
      @product.published
    end

    private

    def set_product
      @product = Product.find(params[:id])
    end
  end

  index do
    id_column
    column :image do |product|
      image_tag product.picture.image_name.url(:small) if product.picture.present?
    end
    column :title
    column(:published) { |product| status_tag product.published }
    column :category
    column :type do |product|
      status_tag product.product_types.first.proportion, color_for_type(product.product_types.first.proportion)
    end
    column :price do |product|
      number_to_currency product.product_types.first.price
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
      row(:published) { |product| status_tag product.published }
      row :description
      row :image do |product|
        image_tag product.picture.image_name.url(:medium) if product.picture.present?
      end
      panel 'Product types' do
        table_for product.product_types do
          column(:proportion) { |type| status_tag type.proportion, color_for_type(type.proportion) }
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
