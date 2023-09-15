class CreateCars < ActiveRecord::Migration[6.1]
  def change
    create_table :cars do |t|
      t.string :name, null: false
      t.text :detail
      t.integer :price, null: false
      t.string :color
      t.integer :passenger_amount
      t.date :year, null: false
      t.string :chassis_code, null: false
      t.integer :mileage, null: false
      t.boolean :is_km, null: false, default: true
      t.integer :shaken_period, null: false
      t.date :shaken_finish
      t.string :grade
      t.integer :engine_capacity
      t.integer :transmission, null: false
      t.integer :fuel, null: false
      t.boolean :is_available, null: false, default: true
      t.timestamps
    end
  end
end
