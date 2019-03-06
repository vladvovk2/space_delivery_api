class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string  :title, unique: true
      t.integer :price
      t.integer :weight
      t.string  :description
      t.timestamps
    end
    add_index :products, %i[title weight price]
  end
end
