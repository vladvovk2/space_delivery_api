class CreatePhoneVerifications < ActiveRecord::Migration[5.2]
  def change
    create_table :phone_verifications do |t|
      t.boolean :verifycation, default: false
      t.string  :phone_number
      t.string  :verifycation_code
      t.timestamps
    end
    add_reference :phone_verifications, :user
    add_index :phone_verifications, :phone_number, unique: true
  end
end
