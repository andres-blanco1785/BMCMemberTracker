# frozen_string_literal: true

# location: spec/integration/payment_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Payments Features', type: :feature do
  let!(:officer) do
    Officer.create(officer_uin: 999_899_799, name: 'Onam', email: 'e@tamu.edu',
                   amount_owed: 15)
  end
  let!(:member) do
    Member.create(member_uin: 111_222_333, first_name: 'Fnam', last_name: 'Lnam',
                  email: 'example@tamu.edu', phone_number: '1234567890', join_date: '1813-01-28')
  end

  let!(:payment) do
    Payment.create(method: 'Cash', date: '2021/09/01', membership_type: 'one semester',
                   membership_expiration: '2021/12/31', amount: 15, member_uin: 111_222_333, officer_uin: 999_899_799)
  end

  let!(:payment_method) { PaymentMethod.create(method: 'Cash') }

  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end

  it 'creating payment w/empty inputs' do
    visit new_payment_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_payment_path
    click_on 'Create Payment'
    # expect(page.has_content?('Member must exist')).to be(true)
    # this is deleted because the member already be selected by default
    # expect(page).to have_content("Officer must exist")
    # this is deleted beacuse the officer already be selected by default
    expect(page.has_content?("Amount can't be blank")).to be(true)

    # No Payment record is created
    expect(Payment.count).to eq(1)
  end

  it 'creating payment w/valid inputs' do
    visit new_payment_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_payment_path
    select 'Cash', from: 'payment[method]'
    select '2021', from: 'payment_date_1i'
    select 'September', from: 'payment_date_2i'
    select '1', from: 'payment_date_3i'
    select 'one semester', from: 'payment[membership_type]'
    select '2021', from: 'payment_membership_expiration_1i'
    select 'December', from: 'payment_membership_expiration_2i'
    select '31', from: 'payment_membership_expiration_3i'
    fill_in 'payment_amount', with: '15'
    # under the hood these are still UIN, but to the BMCT officers names were wanted
    select 'Fnam Lnam, 111222333', from: 'payment_member_uin'
    select 'Onam', from: 'payment_officer_uin'
    click_on 'Create Payment'
    expect(page.has_content?('Payment was successfully created.')).to be(true)
    visit payments_path
    expect(page.has_content?('fnam lnam')).to be(true)
  end

  it 'Destory payment successfully' do
    # A member has been created
    expect(Payment.count).to eq(1)
    visit payments_path
    click_link 'Sign in with your TAMU Google Account'
    visit payments_path
    expect(page.has_content?('2021-09-01')).to be(true)
    click_on 'Delete'
    expect(page.has_content?('Payment was successfully destroyed.')).to be(true)
    expect(Payment.count).to eq(0)
  end

  @payment_method = PaymentMethod.create method: 'Venmo'
  it 'Edit payment successfully' do
    # A payment has been created
    expect(Payment.count).to eq(1)
    visit payments_path
    click_link 'Sign in with your TAMU Google Account'
    visit payments_path
    expect(page.has_content?('Cash')).to be(true)
    expect(page.has_content?('fnam lnam')).to be(true)
    click_on 'Edit'
    select 'Venmo', from: 'payment[method]'
    select '2021', from: 'payment_date_1i'
    select 'September', from: 'payment_date_2i'
    select '1', from: 'payment_date_3i'
    select 'one semester', from: 'payment[membership_type]'
    select '2021', from: 'payment_membership_expiration_1i'
    select 'December', from: 'payment_membership_expiration_2i'
    select '31', from: 'payment_membership_expiration_3i'
    fill_in 'payment_amount', with: '15'
    # OLD: notice changes to selects - creating payment w/valid inputs - if want to do similar to commented
    # fill_in 'payment_member_uin', with: '111222333'
    # select '111222333', :from => 'payment_member_uin'
    # select '987654321', :from => 'payment_officer_uin'
    click_on 'Update Payment'
    expect(page.has_content?('Payment was successfully updated.')).to be(true)
    expect(page.has_content?('Venmo')).to be(true)
    expect(page.has_content?('fnam lnam')).to be(true)
  end
end
