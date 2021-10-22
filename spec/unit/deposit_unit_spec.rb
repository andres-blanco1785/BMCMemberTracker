require 'rails_helper'
RSpec.describe Deposit, type: :model do
  subject do
    described_class.new(officer_uin: '111000123', transcation_id: '111',
      amount: 100, date:"2021-10-03")
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without an officer UIN' do
    subject.officer_uin = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a transaction ID' do
    subject.transcation_id = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without an amount' do
    subject.amount = nil
    expect(subject).not_to be_valid
  end
end
