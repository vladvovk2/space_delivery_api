class CreatePromoCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :promo_codes do |t|
      t.string   :code
      t.integer  :amount, default: 40
      t.boolean  :invite, default: false
      t.timestamps
    end
    add_reference :promo_codes, :user, foreign_key: true
    add_index :promo_codes, :code, unique: true
  end
end
