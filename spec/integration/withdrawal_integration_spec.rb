# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create withdrawal', type: :feature do
  let!(:officer) do
    Officer.create(officer_uin: '631009798',
                   name: 'Yue Hu', email: 'yueh@tamu.edu', amount_owed: 0)
  end
  let!(:transaction_type) { TransactionType.create(category: 'party') }

  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end

  it 'empty officer, category, amount' do
    visit new_withdrawal_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_withdrawal_path
    click_on 'Create Withdrawal'
    expect(page.has_content?("Officer uin can't be blank")).to be(true)
    expect(page.has_content?("Category can't be blank")).to be(true)
    expect(page.has_content?("Amount can't be blank")).to be(true)

    # No Officer record is created
    expect(Withdrawal.count).to eq(0)
  end

  it 'valid inputs' do
    visit new_withdrawal_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_withdrawal_path
    click_on 'Create Withdrawal'

    fill_in 'Officer UIN', with: 631_009_798
    select 'party', from: 'withdrawal_category'
    fill_in 'Amount', with: 10
    fill_in 'withdrawal_title', with: 'happy hour'
    fill_in 'Description', with: 'Just drink and dance'
    click_on 'Create Withdrawal'
    # An officer has been created
    expect(Withdrawal.count).to eq(1)
    expect(page.has_content?('Withdrawal was successfully created.')).to be(true)
    visit withdrawals_path
    expect(page.has_content?('631009798')).to be(true)
    expect(page.has_content?('party')).to be(true)
    expect(page.has_content?('10')).to be(true)
    expect(page.has_content?('happy hour')).to be(true)
    expect(page.has_content?('Just drink and dance')).to be(true)
  end
end

RSpec.describe 'Destroy Withdrawal', type: :feature do
  let!(:officer) do
    Officer.create(officer_uin: '631009798',
                   name: 'Yue Hu', email: 'yueh@tamu.edu', amount_owed: 0)
  end
  let!(:transaction_type) { TransactionType.create(category: 'party') }

  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end

  it 'Destroy successfully' do
    visit new_withdrawal_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_withdrawal_path
    click_on 'Create Withdrawal'
    fill_in 'Officer UIN', with: 631_009_798
    select 'party', from: 'withdrawal_category'
    fill_in 'Amount', with: 10
    fill_in 'withdrawal_title', with: 'happy hour'
    fill_in 'Description', with: 'Just drink and dance'
    click_on 'Create Withdrawal'
    # An Withdrawal has been created
    expect(Withdrawal.count).to eq(1)

    visit withdrawals_path
    click_on 'Destroy'
    expect(page.has_content?('Withdrawal was successfully destroyed.')).to be(true)
    expect(Withdrawal.count).to eq(0)
  end
end

RSpec.describe 'Edit Withdrawal', type: :feature do
  let!(:officer) do
    Officer.create(officer_uin: '631009798',
                   name: 'Yue Hu', email: 'yueh@tamu.edu', amount_owed: 0)
  end
  let!(:transaction_type) { TransactionType.create(category: 'party') }

  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end

  it 'Successfully' do
    visit new_withdrawal_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_withdrawal_path
    click_on 'Create Withdrawal'
    fill_in 'Officer UIN', with: 631_009_798
    select 'party', from: 'withdrawal_category'
    fill_in 'Amount', with: 10
    fill_in 'withdrawal_title', with: 'happy hour'
    fill_in 'Description', with: 'Just drink and dance'
    click_on 'Create Withdrawal'
    # An Withdrawal has been created
    expect(Withdrawal.count).to eq(1)

    visit withdrawals_path
    click_on 'Edit'
    fill_in 'Officer UIN', with: 631_009_798
    select 'party', from: 'withdrawal_category'
    fill_in 'Amount', with: 100
    fill_in 'withdrawal_title', with: 'happy hour111'
    fill_in 'Description', with: 'Just drink and dance111'
    click_on 'Update Withdrawal'
    expect(page.has_content?('Withdrawal was successfully updated')).to be(true)
    expect(page.has_content?('100')).to be(true)
    expect(page.has_content?('happy hour111')).to be(true)
    expect(page.has_content?('Just drink and dance111')).to be(true)
  end
end

RSpec.describe 'Show Withdrawal', type: :feature do
  let!(:officer) do
    Officer.create(officer_uin: '631009798',
                   name: 'Yue Hu', email: 'yueh@tamu.edu', amount_owed: 0)
  end
  let!(:transaction_type) { TransactionType.create(category: 'party') }

  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end

  it 'successfully' do
    visit new_withdrawal_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_withdrawal_path
    click_on 'Create Withdrawal'
    fill_in 'Officer UIN', with: 631_009_798
    select 'party', from: 'withdrawal_category'
    fill_in 'Amount', with: 10
    fill_in 'withdrawal_title', with: 'happy hour'
    fill_in 'Description', with: 'Just drink and dance'
    click_on 'Create Withdrawal'
    # An Withdrawal has been created
    expect(Withdrawal.count).to eq(1)
    visit withdrawals_path
    click_on 'Show'
    expect(page.has_content?('631009798')).to be(true)
    expect(page.has_content?('party')).to be(true)
    expect(page.has_content?('10')).to be(true)
    expect(page.has_content?('happy hour')).to be(true)
    expect(page.has_content?('Just drink and dance')).to be(true)
  end
end
