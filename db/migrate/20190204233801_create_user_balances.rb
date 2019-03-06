class CreateUserBalances < ActiveRecord::Migration[5.2]
  def change
    create_table :user_balances do |t|
      t.integer :balance, default: 0
      t.timestamps
    end

    add_reference :user_balances, :user, foreign_key: true
  end
end
