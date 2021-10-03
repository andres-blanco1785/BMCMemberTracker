class Officer < ApplicationRecord
	has_many :payment
	validates :officer_id, presence: true
	validates :name, presence: true
	validates :email, presence: true 
end
