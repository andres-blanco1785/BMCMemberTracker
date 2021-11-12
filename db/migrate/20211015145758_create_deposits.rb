# frozen_string_literal: true

class CreateDeposits < ActiveRecord::Migration[6.1]
  def change
    create_table :deposits do |t|
      t.integer :deposit_id
      t.integer :officer_uin
      t.float :amount
      t.date :date

      t.timestamps
    end
  end
end
