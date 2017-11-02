class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.integer :campaign_id
      t.string :name
      t.string :email
      t.string :phone
      t.decimal :amount, precision: 10, scale: 2
      t.integer :transaction_id
      t.datetime :time
      t.boolean :is_anonymous
      t.boolean :is_konosioni

      t.timestamps
    end
  end
end
