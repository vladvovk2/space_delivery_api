class AddColumnToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :per_bonuses, :boolean, default: false
    add_column :line_items, :per_bonuses, :boolean, default: false
  end
end
