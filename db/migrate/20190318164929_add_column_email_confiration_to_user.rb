class AddColumnEmailConfirationToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :get_receipt,   :boolean, default: false
    add_column :users, :email_confirm, :boolean, default: false
    add_column :users, :confirm_token, :string
    add_index :users, %i[confirm_token email_confirm]
  end
end
