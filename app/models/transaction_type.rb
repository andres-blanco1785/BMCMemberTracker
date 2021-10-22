class TransactionType < ApplicationRecord
    validates :category, presence: true, uniqueness: true
    self.primary_key = "category"
    has_many :deposits, foreign_key: "deposit_id"
    has_many :withdrawals, foreign_key: "withdrawal_id"
end
