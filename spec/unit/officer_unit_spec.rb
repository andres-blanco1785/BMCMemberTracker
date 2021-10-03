require 'rails_helper'
RSpec.describe Officer, type: :model do
  subject do 
    described_class.new(officer_id: "631009798", name: 'Yue Hu', email: 'yueh@tamu.edu',
                        amountOwed: 200)
  end

  it 'is valid with valid attributes' do 
    expect(subject).to be_valid
  end
  it 'is not valid without an officer ID' do 
    subject.officer_id = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without an name' do 
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without an email' do
    subject.email = nil
    expect(subject).not_to be_valid
  end
end