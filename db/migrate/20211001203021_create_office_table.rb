class CreateOfficeTable < ActiveRecord::Migration[6.1]
  def change
    create_table :officers do |t|
      t.integer :officer_uin
      t.string :name
      t.string :email
      t.float :amount_owed

      t.timestamps
    end
  end
end
