class Member < ApplicationRecord
	has_many :payments,foreign_key: 'member_uin'
	self.primary_key = "member_uin"
	validates :member_uin, presence: true, uniqueness: true
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence:true, uniqueness: true
	validates :phone_number, presence:true
end
