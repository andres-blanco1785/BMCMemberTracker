class CreateTranscationTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :transcation_types do |t|
      t.string :intger
      t.string :transcation_id
      t.category :string

      t.timestamps
    end
  end
end
