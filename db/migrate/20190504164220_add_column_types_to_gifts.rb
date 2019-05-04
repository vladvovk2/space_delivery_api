class AddColumnTypesToGifts < ActiveRecord::Migration[5.2]
  def change
    change_table :gifts, bulk: true do |t|
      t.integer :quantity, default: 0
      t.string :gift_type
      t.index :quantity
      t.index :gift_type
    end

    change_column :gifts, :amount_target, :integer, default: 0
  end
end
