class CreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.integer :uin
      t.string :name
      t.string :email
      t.string :membershipType
      t.date :expiration
      t.date :joinDate

      t.timestamps
    end
  end
end
