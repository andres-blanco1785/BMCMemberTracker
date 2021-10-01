class Change < ActiveRecord::Migration[6.1]
  def change
    rename_table :office_tables, :officers
  end
end
