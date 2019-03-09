class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string    :address
      t.string    :pay_type
      t.string    :last_name
      t.string    :first_name
      t.string    :promo_code
      t.string    :user_number
      t.string    :delivery_type
      t.text      :description
      t.boolean   :status,      default: false
      t.integer   :total_price, default: 0
      t.timestamps
    end
  end
end
