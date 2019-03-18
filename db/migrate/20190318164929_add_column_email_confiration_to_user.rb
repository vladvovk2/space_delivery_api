class AddColumnEmailConfirationToUser < ActiveRecord::Migration[5.2]
  def change
    change_table :users, bulk: true do |t|
      t.boolean :get_receipt, default: false
      t.boolean :email_confirm, default: false
      t.string  :confirm_token
      t.index :confirm_token
      t.index :email_confirm
    end
  end
end
