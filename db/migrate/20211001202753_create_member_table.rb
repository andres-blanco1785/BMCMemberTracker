class CreateMemberTable < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.integer :member_id
      t.string :firstName
      t.string :lastName
      t.string :email
      t.string :phoneNumber
      t.date :joinDate

      t.timestamps
    end
  end
end
