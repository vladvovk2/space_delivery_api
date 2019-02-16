class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string  :title, unique: true
      t.string  :image
      t.string  :description
      t.string  :weight
      t.integer :price
      t.timestamps
    end
    add_index :products, :title
  end
end
