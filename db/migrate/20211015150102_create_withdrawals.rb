class CreateWithdrawals < ActiveRecord::Migration[6.1]
  def change
    create_table :withdrawals do |t|
      t.integer :withdraw_id
      t.integer :officer_uin
      t.integer :transaction_id
      t.float :amount
      t.string :title
      t.string :description
      t.date :date

      t.timestamps
    end
  end
end
