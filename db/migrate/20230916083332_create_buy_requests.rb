class CreateBuyRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :buy_requests do |t|
      t.references :car, null: false, foreign_key: true
      t.text :comment
      t.datetime :option_a, null: false
      t.datetime :option_b, null: false
      t.datetime :option_c, null: false

      t.timestamps
    end
  end
end
