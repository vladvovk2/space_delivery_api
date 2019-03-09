class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string    :first_name
      t.string    :last_name
      t.string    :address
      t.string    :user_number
      t.integer   :total_price, default: 0
      t.string    :delivery_type
      t.string    :pay_type
      t.text      :description
      t.boolean   :status, default: false
      t.string    :promo_code
      t.timestamps
    end
  end
end
