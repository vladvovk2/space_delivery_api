class AddColumnToPromoCode < ActiveRecord::Migration[5.2]
  def change
    change_table :promo_codes, bulk: true do |t|
      t.boolean :percentage
      t.date :limitation
      t.index :percentage
      t.index :limitation
    end
  end
end
