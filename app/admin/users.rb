ActiveAdmin.register User do
  menu priority: 2
  actions :all, except: %i[edit destroy]

  filter :first_name
  filter :last_name
  filter :email
  filter :phone_number
  filter :verification

  index do
    id_column
    column :email
    column :first_name
    column :last_name
    column :verification
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :email
      row :phone_number
      row :first_name
      row :last_name
      row :verification
      row(:promo_code) { |user| user.promo_code.code }
      row(:balance)    { |user| user.user_balance.balance }
      row :created_at

      panel 'Order History' do
        table_for user.orders do
          column(:id) { |order| link_to "Order ##{order.id}", admin_order_path(order) }
          column :status
          column(:total_price) { |order| number_to_currency(order.total_price) }
          column :created_at
        end
      end
    end
  end
end
