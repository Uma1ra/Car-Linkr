class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.references :customer, foreign_key: true
      t.references :buy_request, foreign_key: true
      t.references :sell_request, foreign_key: true
      t.string :name
      t.string :phone_number
      t.string :post_code
      t.integer :category, null: false
      t.boolean :is_done, null: false, default: false

      t.timestamps
    end
  end
end
