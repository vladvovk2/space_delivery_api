class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email,            null: false
      t.string :number,           null: false
      t.string :first_name,       null: false
      t.string :last_name,        null: false
      t.string :image
      t.string :password_digest,  null: false
      t.timestamps
    end
    add_reference :orders, :user, foreign_key: true
  end
end
