class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
    add_reference :places, :order, foreign_key: true
  end
end
