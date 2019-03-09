class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string     :title
      t.string     :description
      t.string     :type, index: true
      t.integer    :price, index: true
      t.integer    :weight, index: true
      t.belongs_to :category, index: true
      t.timestamps
    end
    add_index :products, :title, unique: true
  end
end
