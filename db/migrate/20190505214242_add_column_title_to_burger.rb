class AddColumnTitleToBurger < ActiveRecord::Migration[5.2]
  def change
    add_column :burgers, :title, :string, default: 'unknown'
  end
end
