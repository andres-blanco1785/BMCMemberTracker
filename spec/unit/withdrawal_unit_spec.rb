# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Withdrawal, type: :model do
  subject(:withdrawal) do
    Officer.create(officer_uin: 999_899_799, name: 'Onam', email: 'e@tamu.edu', amount_owed: 15)

    described_class.new(officer_uin: 999_899_799, amount: '10')
  end

  it 'is valid with valid attributes' do
    expect(withdrawal.valid?).to be(true)
  end

  it 'is not valid without a officer' do
    withdrawal.officer_uin = nil
    expect(withdrawal.valid?).to be(false)
  end

  it 'is not valid without an amount' do
    withdrawal.amount = nil
    expect(withdrawal.valid?).to be(false)
  end
end
