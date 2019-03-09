class CreateProductTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :product_types do |t|
      t.string     :type,    index: true
      t.integer    :price,   index: true
      t.integer    :weight,  index: true
      t.references :product, index: true
      t.timestamps
    end
  end
end
