# frozen_string_literal: true

class Officer < ApplicationRecord
  has_many :payments, foreign_key: 'officer_uin'
  has_many :deposits, foreign_key: 'officer_uin'
  has_many :withdrawals, foreign_key: 'officer_uin'

  self.primary_key = 'officer_uin'
  validates :officer_uin, presence: true, uniqueness: true, numericality: true, length: { in: 8..9, message: '. UIN: 8 characters, DL: 9 characters' }

  validates :name, presence: true, format: { with: /\A\D+\z/, message: 'Numbers are not allowed' }
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
end
