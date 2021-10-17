class Officer < ApplicationRecord
	has_many :payment
	validates :officer_uin, presence: true, uniqueness: true
	validates :name, presence: true
	validates :email, presence: true, uniqueness: true 
end
