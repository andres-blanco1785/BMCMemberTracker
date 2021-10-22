class Deposit < ApplicationRecord
    has_many :transaction_types, foreign_key: "category"
end
