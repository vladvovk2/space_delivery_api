class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.timestamps
    end

    add_reference :favorites, :user,    foreign_key: true
    add_reference :favorites, :product, foreign_key: true
  end
end
