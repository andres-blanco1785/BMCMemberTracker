# frozen_string_literal: true

class Member < ApplicationRecord
  has_many :payments, foreign_key: 'member_uin'
  self.primary_key = 'member_uin'
  validates :member_uin, presence: true, uniqueness: true, numericality: true, length: { in: 8..9, message: '. UIN: 8 characters, DL: 9 characters' }
  validates :first_name, presence: true, format: { with: /\A\D+\z/, message: 'Numbers are not allowed' }
  validates :last_name, presence: true, format: { with: /\A\D+\z/, message: 'Numbers are not allowed' }
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :phone_number, presence: true, numericality: true, length: { is: 10 }
  before_save { first_name.downcase! }
  before_save { last_name.downcase! }
  before_save { email.downcase! }
  # this allows payment to display name and uin for member... BMCT wants name, but names aren't unique
  def names_with_uin
    "#{first_name.titleize} #{last_name.titleize}, #{member_uin}"
  end
end
