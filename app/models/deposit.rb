# frozen_string_literal: true

class Deposit < ApplicationRecord
  # # has_many :officers, foreign_key: "officer_uin"
  # belongs_to :officers, primary_key: "officer_uin", foreign_key: "officer_uin"
  belongs_to :officer, foreign_key: 'officer_uin'
  validates :officer_uin, presence: true
  validates :amount, presence: true
  validates :date, presence: true
  # has_many :officers, foreign_key: "officer_uin"
end
