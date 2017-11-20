class ChangeTransactionIdTypeInPaymentsTable < ActiveRecord::Migration[5.1]
  def up
    change_column :payments, :transaction_id, :string
  end

  def down
    change_column :payments, :transaction_id, :integer
  end
end
