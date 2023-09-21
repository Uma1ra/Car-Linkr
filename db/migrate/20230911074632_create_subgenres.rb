class CreateSubgenres < ActiveRecord::Migration[6.1]
  def change
    create_table :subgenres do |t|
      t.references :genre, null:false, foreign_key: true
      t.string :name
      t.timestamps
    end
  end
end
