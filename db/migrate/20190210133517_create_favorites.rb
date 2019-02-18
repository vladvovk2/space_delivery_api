class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table(:favorites) { |t| t.timestamps }

    add_reference :favorites, :user,    foreign_key: true
    add_reference :favorites, :product, foreign_key: true
  end
end
