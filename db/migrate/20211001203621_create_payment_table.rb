class CreatePaymentTable < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_tables do |t|
      t.integer :paymentId
      t.string :paymentMethod
      t.date :date
      t.string :membershipType
      t.date :membershipExpiration
      t.float :amount

      t.timestamps
    end
  end
end
