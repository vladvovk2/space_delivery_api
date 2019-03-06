class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      t.integer :quantity, default: 1
      t.timestamps
    end
    add_reference :line_items, :product, foreign_key: true
  end
end
