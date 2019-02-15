class CreatePhoneVerifications < ActiveRecord::Migration[5.2]
  def change
    create_table :phone_verifications do |t|
      t.boolean :verification, default: false
      t.string  :phone_number
      t.string  :verification_code
      t.timestamps
    end
    add_reference :phone_verifications, :user
    add_index :phone_verifications, :phone_number, unique: true
  end
end
