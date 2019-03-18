class AddColumnEmailConfirationToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email_confirm, :boolean, default: false
    add_index :users, :email_confirm
  end
end
