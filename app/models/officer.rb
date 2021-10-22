class Officer < ApplicationRecord

	has_many :payments, foreign_key:"officer_uin"
	has_many :deposits, foreign_key:"officer_uin"
	
	self.primary_key = "officer_uin"
	validates :officer_uin, presence: true, uniqueness: true

	validates :name, presence: true
	validates :email, presence: true, uniqueness: true
end
