class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :adress
      t.string :user_number
      t.string :total_price
      t.text   :description
      t.timestamps
    end

    add_reference :line_items, :order, foreign_key: true
  end
end
# delivery_type, pay_type, delivery_time, promo