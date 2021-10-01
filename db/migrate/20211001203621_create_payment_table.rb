class CreatePaymentTable < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.integer :paymentId
      t.string :paymentMethod
      t.date :date
      t.string :membershipType
      t.date :membershipExpiration
      t.float :amount
      t.integer :member_id
      t.integer :officer_id

      t.timestamps
    end
  end
end
