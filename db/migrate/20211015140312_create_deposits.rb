class CreateDeposits < ActiveRecord::Migration[6.1]
  def change
    create_table :deposits do |t|
      t.deposit_id :integer
      t.officer_uin :integer
      t.transcation_id :integer
      t.amount :float
      t.date :date

      t.timestamps
    end
  end
end
