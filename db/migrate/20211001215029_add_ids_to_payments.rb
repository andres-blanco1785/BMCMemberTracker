class AddIdsToPayments < ActiveRecord::Migration[6.1]
  def change
    add_column :payments, :member_id, :integer
    add_column :payments, :officer_id, :integer
  end
end
