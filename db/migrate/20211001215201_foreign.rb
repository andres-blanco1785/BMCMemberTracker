class Foreign < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :payments, :members
    add_foreign_key :payments, :officers
  end
end
