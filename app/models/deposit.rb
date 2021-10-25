class Deposit < ApplicationRecord
  has_many :transaction_types, foreign_key: "category"
  has_many :officers, foreign_key: "officer_uin"
  validates :officer_uin, presence: true
  validates :category, presence: true
  validates :amount, presence: true
  validates :date, presence: true
end
