class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string  :first_name
      t.string  :second_name
      t.string  :adress
      t.string  :user_number
      t.string  :total_price
      t.string  :delivery_type
      t.string  :pay_type
      t.text    :description
      t.boolean :status, default: false
      t.string  :promo_code
      t.timestamps
    end

    add_reference :line_items, :order, foreign_key: true
  end
end