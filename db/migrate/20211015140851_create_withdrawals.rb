class CreateWithdrawals < ActiveRecord::Migration[6.1]
  def change
    create_table :withdrawals do |t|
      t.withdraw_id :integer
      t.officer_uin :integer
      t.transaction_id :integer
      t.amount :float
      t.title :string
      t.description :string
      t.date :date

      t.timestamps
    end
  end
end
