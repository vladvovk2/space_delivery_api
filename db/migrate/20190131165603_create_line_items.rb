class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      t.integer     :quantity, default: 1
      t.references  :product, foreign_key: true
      t.timestamps
    end
  end
end
