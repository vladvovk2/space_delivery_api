class AddColumnToPromoCode < ActiveRecord::Migration[5.2]
  def change
    change_table :promo_codes, bulk: true do |t|
      t.boolean :percentage, default: false
      t.boolean :used, default: false
      t.date :limitation
      t.index :used
      t.index :percentage
      t.index :limitation
    end
    add_reference :promo_codes, :order, foreign_key: true
    add_column :orders, :discount, :integer, default: 0
    remove_column :orders, :promo_code, :string
  end
end
