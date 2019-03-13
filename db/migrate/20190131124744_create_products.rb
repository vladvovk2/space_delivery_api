class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string     :title
      t.string     :description
      t.index :title, unique: true
      t.timestamps
    end
  end
end
