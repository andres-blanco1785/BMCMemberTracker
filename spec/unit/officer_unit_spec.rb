# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Officer, type: :model do
  subject(:officer) do
    described_class.new(officer_uin: '631009798', name: 'Yue Hu', email: 'yueh@tamu.edu',
                        amount_owed: 200)
  end

  it 'is valid with valid attributes' do
    expect(officer.valid?).to be(true)
  end

  it 'is not valid without an officer ID' do
    officer.officer_uin = nil
    expect(officer.valid?).to be(false)
  end

  it 'is not valid without an name' do
    officer.name = nil
    expect(officer.valid?).to be(false)
  end

  it 'is not valid without an email' do
    officer.email = nil
    expect(officer.valid?).to be(false)
  end
end
