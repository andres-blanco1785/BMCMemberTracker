class PaymentMethod < ApplicationRecord
    validates :method, presence: true, uniqueness: true
    self.primary_key = 'method'
    has_many :payments, foreign_key: 'method'
end