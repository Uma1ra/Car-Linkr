class CreateEnquiries < ActiveRecord::Migration[6.1]
  def change
    create_table :enquiries do |t|
      t.references :customer, foreign_key: true
      t.string :phone_number
      t.string :email
      t.string :title, null: false
      t.text :detail, null: false

      t.timestamps
    end
  end
end
