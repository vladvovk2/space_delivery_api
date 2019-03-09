class CreateUserBalances < ActiveRecord::Migration[5.2]
  def change
    create_table :user_balances do |t|
      t.integer :balance, default: 0
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
