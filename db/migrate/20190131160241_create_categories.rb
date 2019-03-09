class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :title
      t.index :title, unique: true
      t.timestamps
    end
    add_foreign_key :products, :categories
  end
end
