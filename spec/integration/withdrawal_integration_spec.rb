# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Withdrawal Features', type: :feature do
  let!(:officer) do
    Officer.create(officer_uin: '631009798',
                   name: 'Yue Hu', email: 'yueh@tamu.edu', amount_owed: 0)
  end

  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end

  it 'Create Withdrawal w/empty officer, amount' do
    visit new_withdrawal_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_withdrawal_path
    click_on 'Create Withdrawal'
    expect(page.has_content?("Officer uin can't be blank")).to be(true)
    expect(page.has_content?("Amount can't be blank")).to be(true)

    # No Officer record is created
    expect(Withdrawal.count).to eq(0)
  end

  it 'Create Withdrawal w/valid inputs' do
    visit new_withdrawal_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_withdrawal_path
    click_on 'Create Withdrawal'

    select 'Yue Hu', from: 'withdrawal_officer_uin'
    fill_in 'Amount', with: 10
    fill_in 'Notes', with: 'Just drink and dance'
    click_on 'Create Withdrawal'
    # An officer has been created
    expect(Withdrawal.count).to eq(1)
    expect(page.has_content?('Withdrawal was successfully created.')).to be(true)
    visit withdrawals_path
    expect(page.has_content?('Yue Hu')).to be(true)
    expect(page.has_content?('10')).to be(true)
    expect(page.has_content?('Just drink and dance')).to be(true)
  end

  it 'Destroy Withdrawal successfully' do
    visit new_withdrawal_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_withdrawal_path
    click_on 'Create Withdrawal'
    select 'Yue Hu', from: 'withdrawal_officer_uin'
    fill_in 'Amount', with: 10
    fill_in 'Notes', with: 'Just drink and dance'
    click_on 'Create Withdrawal'
    # An Withdrawal has been created
    expect(Withdrawal.count).to eq(1)

    visit withdrawals_path
    click_on 'Delete'
    expect(page.has_content?('Withdrawal was successfully destroyed.')).to be(true)
    expect(Withdrawal.count).to eq(0)
  end

  it 'Edit Withdrawal Successfully' do
    visit new_withdrawal_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_withdrawal_path
    click_on 'Create Withdrawal'
    select 'Yue Hu', from: 'withdrawal_officer_uin'
    fill_in 'Amount', with: 10
    fill_in 'Notes', with: 'Just drink and dance'
    click_on 'Create Withdrawal'
    # An Withdrawal has been created
    expect(Withdrawal.count).to eq(1)

    visit withdrawals_path
    click_on 'Edit'
    select 'Yue Hu', from: 'withdrawal_officer_uin'
    fill_in 'Amount', with: 100
    fill_in 'Notes', with: 'Just drink and dance111'
    click_on 'Update Withdrawal'
    expect(page.has_content?('Withdrawal was successfully updated')).to be(true)
    expect(page.has_content?('100')).to be(true)
    expect(page.has_content?('Just drink and dance111')).to be(true)
  end

  it 'Show Withdrawal successfully' do
    visit new_withdrawal_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_withdrawal_path
    click_on 'Create Withdrawal'
    select 'Yue Hu', from: 'withdrawal_officer_uin'
    fill_in 'Amount', with: 10
    fill_in 'Notes', with: 'Just drink and dance'
    click_on 'Create Withdrawal'
    # An Withdrawal has been created
    expect(Withdrawal.count).to eq(1)
    visit withdrawals_path
    expect(page.has_content?('Yue Hu')).to be(true)
    expect(page.has_content?('10')).to be(true)
    expect(page.has_content?('Just drink and dance')).to be(true)
  end
end
