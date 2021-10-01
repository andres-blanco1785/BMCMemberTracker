class ChangePayments < ActiveRecord::Migration[6.1]
  def change
    rename_table :payment_tables, :payments
  end
end
