class CreateCars < ActiveRecord::Migration[6.1]
  def change
    create_table :cars do |t|
      t.string :name, null: false
      t.text :detail, null: false
      t.integer :price, null: false
      t.string :color, null: false
      t.integer :passenger_amount, null: false
      t.date :year, null: false
      t.string :chassis_code, null: false
      t.integer :mileage, null: false
      t.boolean :is_km, null: false, default: true
      t.integer :shaken_period, null: false
      t.datetime :shaken_finish, null: false
      t.string :grade, null: false
      t.integer :engine_capacity, null: false
      t.integer :transmission, null: false
      t.integer :fuel, null: false
      t.boolean :is_available, null: false, default: true
      t.timestamps
    end
  end
end
