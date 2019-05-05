class CreateBurgers < ActiveRecord::Migration[5.2]
  def change
    create_table :burgers, &:timestamps
    add_reference :line_items, :burger, foreign_key: true
  end
end
