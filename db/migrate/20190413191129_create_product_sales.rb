class CreateProductSales < ActiveRecord::Migration[5.2]
  def change
    create_table :product_sales do |t|
      t.integer :active_id
      t.integer :pasive_id
      t.index %i[active_id pasive_id], unique: true
      t.timestamps
    end

    add_column :products, :published, :boolean, defualt: false
  end
end
