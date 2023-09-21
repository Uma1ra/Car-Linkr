class CreateSellDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :sell_details do |t|
      t.references :sell_request, null: false, foreign_key: true
      t.string :car_name, null: false
      t.string :chassis_no, null: false
      t.date :year, null: false
      t.string :chassis_code, null: false
      t.integer :mileage, null: false
      t.boolean :is_km, null: false, default: true
      t.integer :shaken_period, null: false
      t.date :shaken_finish

      t.timestamps
    end
  end
end
