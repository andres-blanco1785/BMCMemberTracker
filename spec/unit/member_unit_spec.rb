require 'rails_helper'
RSpec.describe Member, type: :model do
  subject do 
    described_class.new(member_id: "727002594", first_name: 'Andres', last_name: 'Blanco', email: 'andresblanco1785@tamu.edu',
                        phone_number: "8326608665", join_date: "2021-10-03")
  end

  it 'is valid with valid attributes' do 
    expect(subject).to be_valid
  end
  it 'is not valid without an member ID' do 
    subject.member_id = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a first name' do 
    subject.first_name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a last name' do 
    subject.last_name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without an email' do
    subject.email = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a phone number' do
    subject.phone_number = nil
    expect(subject).not_to be_valid
  end

end