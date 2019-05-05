class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.integer :price, default: 0
      t.string :ingredient_type
      t.string :title
      t.index :title
      t.index :price
      t.timestamps
    end

    create_table :components do |t|
      t.integer :quantity, default: 1
      t.index :quantity
      t.timestamps
    end

    add_reference :components, :burger, foreign_key: true
    add_reference :components, :ingredient, foreign_key: true
  end
end
