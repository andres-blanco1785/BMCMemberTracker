class Member < ApplicationRecord
	has_many :payments
	has_many :officers, through: :payments
end
