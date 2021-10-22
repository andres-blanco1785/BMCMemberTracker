class Deposit < ApplicationRecord
  belongs_to :officer, :foreign_key => 'officer_uin', :primary_key => 'officer_uin'
  belongs_to :transaction_type, :foreign_key => 'transaction_num', :primary_key => 'transaction_num'
  validates :officer_uin, presence: true
	validates :transaction_id, presence: true
  validates :amount, presence: true
  validates :date, presence: true
end
