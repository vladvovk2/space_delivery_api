class CreateGifts < ActiveRecord::Migration[5.2]
  def change
    create_table :gifts do |t|
      t.integer :amount_target
      t.date :limitation
      t.timestamps
    end
    add_reference :gifts, :product, foreign_key: true
    add_reference :line_items, :gift, foreign_key: true
  end
end
