class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :title
      t.timestamps
    end
    add_index :categories, :title, unique: true
    add_foreign_key :products, :categories
  end
end
