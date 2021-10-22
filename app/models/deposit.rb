class Deposit < ApplicationRecord
  has_many :officers, foreign_key: "officer_uin"
  has_many :transaction_types, foreign_key: "category"
  validates :officer_uin, presence: true
	validates :transaction_id, presence: true
  validates :amount, presence: true
  validates :date, presence: true
end
