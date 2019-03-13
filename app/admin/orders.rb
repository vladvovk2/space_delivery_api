ActiveAdmin.register Order do
  menu priority: 3

  actions :all, except: %i[edit destroy]

  before_action :set_order, only: %i[in_process deliver]

  scope :all
  scope :complete
  scope :pending
  scope :processing

  filter :first_name
  filter :last_name
  filter :user_number
  filter :created_at

  action_item :in_process, only: :show do
    link_to 'Accomplish', in_process_admin_order_path, method: :put unless status_complite?
  end

  action_item :deliver, only: :show do
    link_to 'Completed', deliver_admin_order_path, method: :put unless status_complite?
  end

  member_action :in_process, method: :put do
    @order.update(status: 'Processing')
    redirect_to admin_order_path(@order)
  end

  member_action :deliver, method: :put do
    @order.update(status: 'Complete')
    redirect_to admin_order_path(@order)
  end

  controller do
    helper_method :status_complite?

    def scoped_collection
      super.includes(:user, line_items: { product_type: { product: :picture } })
    end

    def status_complite?
      @order.status.eql? 'Complete'
    end

    def set_order
      @order = Order.find(params[:id])
    end
  end

  index do
    column(&:user)
    column :first_name
    column :last_name
    column :user_number
    column :status
    column(:total_price) { |order| number_to_currency(order.total_price) }
    column :created_at
    actions
  end

  show do
    attributes_table do
      row(:user) { |order| order.user }
      row :first_name
      row :last_name
      row :user_number
      row :status
      row :pay_type
      row :delivery_type
      row :created_at
      row :promo_code
      row :description
      row(:total_price) { |order| number_to_currency(order.total_price) }

      panel 'Product list' do
        table_for order.line_items do
          column(:image) do |order|
            image_tag order.product_type.product.picture.image_name.url(:small)
          end
          column(:title) { |order| order.product_type.product.title }
          column :quantity
          column(:price) { |order| number_to_currency(order.product_type.price) }
          column(:total_price) { |order| number_to_currency(order.product_type.price * order.quantity) }
        end
      end
    end
  end
end
