# location: spec/unit/payment_unit_spec.rb
require 'rails_helper'

RSpec.describe Payment, type: :model do
  subject do
  mem_id_temp = Member.create(member_id: 111222333, firstName: 'Fnam', lastName: 'Lnam',
  email: 'example@tamu.edu', phoneNumber: '1234567890', joinDate: '1813-01-28')
  off_id_temp = Officer.create(officer_id: 999899799, name: 'Onam', email: 'e@tamu.edu',
  amountOwed: 15)
  described_class.new(paymentId: 1, paymentMethod: 'cash', date: '1813-01-28',
	membershipType: 'one semester', membershipExpiration: '1813-01-28', amount: 15,
	member_id: 111222333, officer_id: 999899799)
  end

  it 'is not valid without a paymentId' do
    subject.paymentId = nil
    expect(subject).not_to be_valid
  end
  
  it 'is not valid without a paymentMethod' do
    subject.paymentMethod = nil
    expect(subject).not_to be_valid
  end
  
  it 'is not valid without a date' do
    subject.date = nil
    expect(subject).not_to be_valid
  end
  
  it 'is not valid without a membershipType' do
    subject.membershipType = nil
    expect(subject).not_to be_valid
  end
  
  it 'is not valid without a membershipExpiration' do
    subject.membershipExpiration = nil
    expect(subject).not_to be_valid
  end
  
  it 'is not valid without a amount' do
    subject.amount = nil
    expect(subject).not_to be_valid
  end
  
  it 'is not valid without a member_id' do
    subject.member_id = nil
    expect(subject).not_to be_valid
  end
  
  it 'is not valid without a officer_id' do
    subject.officer_id = nil
    expect(subject).not_to be_valid
  end
end