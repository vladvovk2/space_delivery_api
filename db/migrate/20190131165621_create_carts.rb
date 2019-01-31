class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.timestamps
    end
    add_reference :line_items, :cart, foreign_key: true
  end
end
