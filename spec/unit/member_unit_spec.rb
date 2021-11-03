# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Member, type: :model do
  subject(:member) do
    described_class.new(member_uin: '727002594', first_name: 'Andres', last_name: 'Blanco', email: 'andresblanco1785@tamu.edu',
                        phone_number: '8326608665', join_date: '2021-10-03')
  end

  it 'is valid with valid attributes' do
    expect(member.valid?).to be(true)
  end

  it 'is not valid without an member ID' do
    member.member_uin = nil
    expect(member.valid?).to be(false)
  end

  it 'is not valid without a first name' do
    member.first_name = nil
    expect(member.valid?).to be(false)
  end

  it 'is not valid without a last name' do
    member.last_name = nil
    expect(member.valid?).to be(false)
  end

  it 'is not valid without an email' do
    member.email = nil
    expect(member.valid?).to be(false)
  end

  it 'is not valid without a phone number' do
    member.phone_number = nil
    expect(member.valid?).to be(false)
  end
end
