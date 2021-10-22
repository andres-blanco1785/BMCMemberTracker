class CreatePaymentTable < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.integer :payment_id
      t.string :payment_mtd
      t.date :date
      t.string :membership_type
      t.date :membership_expiration
      t.float :amount
      t.integer :member_uin, foreign_key:{ to_table: :payments}
      t.integer :officer_uin, foreign_key:{ to_table: :payments}

      t.timestamps
    end
  end
end
