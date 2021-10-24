# location: spec/unit/payment_unit_spec.rb
require 'rails_helper'

RSpec.describe Payment, type: :model do
  # need to pass google sign in to get to payment tests
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end
	
  subject do
  mem_id_temp = Member.create(member_uin: 111222333, first_name: 'Fnam', last_name: 'Lnam',
  email: 'ja7davis@gmail.com', phone_number: '1234567890', join_date: '1813-01-28')
  off_id_temp = Officer.create(officer_uin: 999899799, name: 'Onam', email: 'ja7davis@tamu.edu',
  amount_owed: 15)
  described_class.new(payment_id: 111, payment_mtd: 'cash', date: '1813-01-28',
	membership_type: 'one semester', membership_expiration: '1813-01-28', amount: 15,
	member_uin: 111222333, officer_uin: 999899799)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  
  it 'is not valid without a paymentMethod' do
    subject.payment_mtd = nil
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
  
  it 'is not valid without a member_uin' do
    subject.member_uin = nil
    expect(subject).not_to be_valid
  end
  
  it 'is not valid without a officer_uin' do
    subject.officer_uin = nil
    expect(subject).not_to be_valid
  end
end
