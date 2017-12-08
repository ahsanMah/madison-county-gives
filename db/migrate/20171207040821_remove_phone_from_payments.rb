class RemovePhoneFromPayments < ActiveRecord::Migration[5.1]
  def change
    remove_column :payments, :phone, :string
  end
end
