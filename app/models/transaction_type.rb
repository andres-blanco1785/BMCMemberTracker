# frozen_string_literal: true

class TransactionType < ApplicationRecord
  validates :category, presence: true, uniqueness: true
  self.primary_key = 'category'
  has_many :deposits, foreign_key: 'category'
  has_many :withdrawals, foreign_key: 'category'
end
