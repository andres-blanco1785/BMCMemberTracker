class Withdrawal < ApplicationRecord
    belongs_to :transaction_type, primary_key: "category", foreign_key: "category"
end
