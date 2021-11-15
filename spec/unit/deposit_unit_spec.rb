# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Deposit, type: :model do
  subject(:deposit) do
    Officer.create(officer_uin: '111000123', name: 'XiXi', email: 'xixi@tamu.edu', amount_owed: 0)
    described_class.new(officer_uin: '111000123', amount: 100, date: '2021-10-03')
  end

  it 'is valid with valid attributes' do
    expect(deposit.valid?).to be(true)
  end

  it 'is not valid without an officer UIN' do
    deposit.officer_uin = nil
    expect(deposit.valid?).to be(false)
  end

  it 'is not valid without an amount' do
    deposit.amount = nil
    expect(deposit.valid?).to be(false)
  end
end
