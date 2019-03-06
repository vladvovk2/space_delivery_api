class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.string :image_name
      t.references :imageable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
