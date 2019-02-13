class CreatePhoneVerifications < ActiveRecord::Migration[5.2]
  def change
    create_table :phone_verifications do |t|
      t.boolean :verifycation, default: false
      t.string  :phone_number
      t.timestamps
    end
    add_reference :users, :phone_verifications
    add_index :phone_verifications, :phone_number, unique: true
  end
end
