# frozen_string_literal: true

class Member < ApplicationRecord
  has_many :payments, foreign_key: 'member_uin'
  self.primary_key = 'member_uin'
  validates :member_uin, presence: true, uniqueness: true, numericality: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true
  before_save { first_name.downcase! }
  before_save { last_name.downcase! }
  before_save { email.downcase! }
  # this allows payment to display name and uin for member... BMCT wants name, but names aren't unique
  def names_with_uin
    "#{first_name.titleize} #{last_name.titleize}, #{member_uin}"
  end
end
