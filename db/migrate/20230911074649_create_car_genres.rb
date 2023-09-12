class CreateCarGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :car_genres do |t|
      t.references :genre, null: false, foreign_key: true
      t.references :car, null: false, foreign_key: true
      t.timestamps
    end
  end
end
