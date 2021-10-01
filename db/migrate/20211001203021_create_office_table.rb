class CreateOfficeTable < ActiveRecord::Migration[6.1]
  def change
    create_table :office_tables do |t|
      t.integer :officerUIN
      t.string :name
      t.string :email
      t.float :amountOwed

      t.timestamps
    end
  end
end
