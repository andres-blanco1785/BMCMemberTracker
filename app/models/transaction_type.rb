class TransactionType < ApplicationRecord
    validates :category, presence: true, uniqueness: true
end
