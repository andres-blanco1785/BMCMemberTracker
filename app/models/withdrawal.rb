class Withdrawal < ApplicationRecord
    belongs_to :transaction_type, primary_key: "category", foreign_key: "category"
    belongs_to :officer, primary_key: "officer_uin", foreign_key: "officer_uin"
end
