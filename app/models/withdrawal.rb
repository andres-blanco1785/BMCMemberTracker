# frozen_string_literal: true

class Withdrawal < ApplicationRecord
  has_many :officers, foreign_key: 'officer_uin'

  validates :officer_uin, presence: true
  validates :amount, presence: true
end
