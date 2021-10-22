class Deposit < ApplicationRecord
  validates :officer_uin, presence: true
	validates :transaction_id, presence: true
  validates :amount, presence: true
  validates :date, prsence: true
end
