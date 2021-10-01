class Rename < ActiveRecord::Migration[6.1]
  def change
    rename_column :members, :UIN, :member_id
    rename_column :officers, :officerUIN, :officer_id
  end
end
