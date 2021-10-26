require 'rails_helper'

RSpec.describe Withdrawal, type: :model do
  subject do
 
  off_uin_temp = Officer.create(officer_uin: 999899799, name: 'Onam', email: 'e@tamu.edu',
  amount_owed: 15)
  trans_type_temp = TransactionType.create(category: 'party')
  
  described_class.new(officer_uin: 999899799, category: "party", amount:"10")
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  
  it 'is not valid without a officer ' do
    subject.officer_uin = nil
    expect(subject).not_to be_valid
  end
  
  it 'is not valid without a category' do
    subject.category = nil
    expect(subject).not_to be_valid
  end
  
  it 'is not valid without an amount' do
    subject.amount = nil
    expect(subject).not_to be_valid
  end
  
end