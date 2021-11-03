# frozen_string_literal: true

class Withdrawal < ApplicationRecord
  has_many :transaction_type, foreign_key: 'category'
  has_many :officers, foreign_key: 'officer_uin'

  validates :officer_uin, presence: true
  validates :category, presence: true
  validates :amount, presence: true
end
