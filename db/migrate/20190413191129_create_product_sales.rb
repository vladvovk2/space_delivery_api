class CreateProductSales < ActiveRecord::Migration[5.2]
  def change
    create_table :product_sales do |t|
      t.integer :sales_count, default: 0
      t.integer :active_id
      t.integer :passive_id
      t.timestamps
    end
    add_index :product_sales, :active_id
    add_index :product_sales, :passive_id
    add_index :product_sales, %i[active_id passive_id], unique: true
    add_column :products, :published, :boolean, defualt: false
  end
end
