class Changemembers < ActiveRecord::Migration[6.1]
  def change
    rename_table :member_tables, :members
  end
end
