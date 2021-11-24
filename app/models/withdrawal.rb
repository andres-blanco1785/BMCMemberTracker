# frozen_string_literal: true

class Withdrawal < ApplicationRecord
  belongs_to :officer, foreign_key: 'officer_uin'

  validates :officer_uin, presence: true
  validates :amount, presence: true, numericality: true
end
