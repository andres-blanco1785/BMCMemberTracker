class Payment < ApplicationRecord
	belongs_to :member, foreign_key: true
	belongs_to :officer, foreign_key: true
	
	#validates_presence_of :member
	#validates_presence_of :officer
	
	validates :paymentId, presence: true
	validates :paymentMethod, presence: true
	validates :date, presence: true
	validates :membershipType, presence: true
	validates :membershipExpiration, presence: true
	validates :amount, presence: true
	validates :member_id, presence: true
	validates :officer_id, presence: true
end
