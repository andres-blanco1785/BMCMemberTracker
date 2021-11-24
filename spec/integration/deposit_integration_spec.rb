# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Testing Deposit', type: :feature do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end

  let!(:officer) { Officer.create(officer_uin: '111000123', name: 'Yue Hu', email: 'yueh@tamu.edu', amount_owed: 0) }

  let!(:deposit) do
    Deposit.create(officer_uin: '111000123', amount: 100, date: '2021-10-21')
  end

  it 'empty officer uin, amount, and date' do
    visit new_member_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_deposit_path
    click_on 'Create Deposit'
    expect(page.has_content?("Officer uin can't be blank")).to be(true)
    expect(page.has_content?("Amount can't be blank")).to be(true)
    # No deposit record is created
    expect(Deposit.count).to eq(1)
  end

  it 'valid inputs' do
    visit new_member_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_deposit_path
    select 'Yue Hu', from: 'deposit_officer_uin'
    fill_in 'deposit_amount', with: 20
    select '2021', from: 'deposit_date_1i'
    select 'December', from: 'deposit_date_2i'
    select '31', from: 'deposit_date_3i'
    click_on 'Create Deposit'
    # An deposit has been created
    expect(Deposit.count).to eq(2)
    expect(page.has_content?('Deposit was successfully created.')).to be(true)
    visit deposits_path
    expect(page.has_content?('Yue Hu')).to be(true)
    expect(page.has_content?('20')).to be(true)
    expect(page.has_content?('2021-10-21')).to be(true)
  end

  it 'destory deposit' do
    # An deposit has been created
    visit new_member_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_deposit_path
    expect(Deposit.count).to eq(1)
    visit deposits_path
    expect(page.has_content?('Yue Hu')).to be(true)
    expect(page.has_content?('100')).to be(true)
    expect(page.has_content?('2021-10-21')).to be(true)
    click_on 'Destroy'
    expect(page.has_content?('Deposit was successfully destroyed.')).to be(true)
    expect(Deposit.count).to eq(0)
  end

  it 'update deposit' do
    Officer.create(officer_uin: '100_000_001', name: 'XiXi', email: 'xixi@tamu.edu', amount_owed: 0)
    visit new_member_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_deposit_path
    expect(Deposit.count).to eq(1)
    visit deposits_path
    expect(page.has_content?('Yue Hu')).to be(true)
    expect(page.has_content?('100')).to be(true)
    expect(page.has_content?('2021-10-21')).to be(true)
    click_on 'Edit'
    select 'XiXi', from: 'deposit_officer_uin'
    fill_in 'deposit_amount', with: 200
    select '2021', from: 'deposit_date_1i'
    select 'December', from: 'deposit_date_2i'
    select '31', from: 'deposit_date_3i'
    click_on 'Update Deposit'
    expect(page.has_content?('XiXi')).to be(true)
    expect(page.has_content?('200')).to be(true)
    expect(page.has_content?('2021-12-31')).to be(true)
  end
end
