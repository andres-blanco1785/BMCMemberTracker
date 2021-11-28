# frozen_string_literal: true

# location: spec/unit/payment_unit_spec.rb
require 'rails_helper'

RSpec.describe Payment, type: :model do
  subject(:payment) do
    Member.create(member_uin: 111_222_333, first_name: 'Fnam', last_name: 'Lnam', email: 'example@tamu.edu', phone_number: '1234567890', join_date: '1813-01-28')
    Officer.create(officer_uin: 999_899_799, name: 'Onam', email: 'e@tamu.edu', amount_owed: 15)
    described_class.new(payment_id: 111, method: 'cash', date: '1813-01-28', membership_type: 'one semester', amount: 15, member_uin: 111_222_333, officer_uin: 999_899_799)
  end

  it 'is valid with valid attributes' do
    expect(payment.valid?).to be(true)
  end

  it 'is not valid without a paymentMethod' do
    payment.method = nil
    expect(payment.valid?).to be(false)
  end

  it 'is not valid without a date' do
    payment.date = nil
    expect(payment.valid?).to be(false)
  end

  it 'is not valid without a membershipType' do
    payment.membership_type = nil
    expect(payment.valid?).to be(false)
  end

  it 'is not valid without a amount' do
    payment.amount = nil
    expect(payment.valid?).to be(false)
  end

  it 'is not valid without a member_uin' do
    payment.member_uin = nil
    expect(payment.valid?).to be(false)
  end

  it 'is not valid without a officer_uin' do
    payment.officer_uin = nil
    expect(payment.valid?).to be(false)
  end
end
