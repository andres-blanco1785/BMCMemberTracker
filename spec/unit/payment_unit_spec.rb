# location: spec/unit/payment_unit_spec.rb
require 'rails_helper'

RSpec.describe Payment, type: :model do
  subject do
  mem_id_temp = Member.create(member_id: 111222333, first_name: 'Fnam', last_name: 'Lnam',
  email: 'example@tamu.edu', phone_number: '1234567890', join_date: '1813-01-28')
  off_id_temp = Officer.create(officer_id: 999899799, name: 'Onam', email: 'e@tamu.edu',
  amount_owed: 15)
  described_class.new(payment_id: 111, payment_method: 'cash', date: '1813-01-28',
	membership_type: 'one semester', membership_expiration: '1813-01-28', amount: 15,
	member_id: 111222333, officer_id: 999899799)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  
  it 'is not valid without a paymentMethod' do
    subject.payment_method = nil
    expect(subject).not_to be_valid
  end
  
  it 'is not valid without a date' do
    subject.date = nil
    expect(subject).not_to be_valid
  end
  
  it 'is not valid without a membershipType' do
    subject.membership_type = nil
    expect(subject).not_to be_valid
  end
  
  it 'is not valid without a membershipExpiration' do
    subject.membership_expiration = nil
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
