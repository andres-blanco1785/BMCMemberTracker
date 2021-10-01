class CreateMemberTable < ActiveRecord::Migration[6.1]
  def change
    create_table :member_tables do |t|
      t.integer :UIN
      t.string :firstName
      t.string :lastName
      t.string :email
      t.string :phoneNumber
      t.date :joinDate

      t.timestamps
    end
  end
end
