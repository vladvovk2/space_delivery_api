class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string  :title, unique: true
      t.string  :description
      t.integer :weight
      t.integer :price
      t.string  :image
      t.string  :image_url
      t.timestamps
    end
    add_index :products, %i[title weight price]
  end
end
