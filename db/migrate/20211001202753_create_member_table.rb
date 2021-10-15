class CreateMemberTable < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.integer :member_uin
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.date :join_date

      t.timestamps
    end
  end
end
