class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string  :email,              null: false
      t.string  :last_name,          null: false
      t.string  :first_name,         null: false
      t.string  :phone_number,       null: false
      t.string  :password_digest,    null: false
      t.boolean :verification,       default: false
      t.string  :avatar
      t.timestamps
    end
    add_reference :orders, :user, foreign_key: true
    add_reference :carts,  :user, foreign_key: true
    add_index :users, %i[email phone_number], unique: true
  end
end
