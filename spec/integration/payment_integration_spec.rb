# location: spec/integration/payment_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Creating a payment', type: :feature do
  let!(:officer) { Officer.create(officer_uin: 999899799, name: 'Onam', email: 'e@tamu.edu', 
  amount_owed: 15) }
  let!(:member) { Member.create(member_uin: 111222333, first_name: 'Fnam', last_name: 'Lnam', 
  email: 'example@tamu.edu', phone_number: '1234567890', join_date: '1813-01-28') }
  
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end

  scenario 'empty inputs' do
  
    visit new_payment_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_payment_path
    click_on 'Create Payment'
    expect(page).to have_content("Member must exist")
    #expect(page).to have_content("Officer must exist") 
    #this is deleted beacuse the officer already be selected by default
    expect(page).to have_content("Amount can't be blank")

    # No Payment record is created
    expect(Payment.count).to eq(0)
  end
  
  scenario 'valid inputs' do
  
  visit new_payment_path
  click_link 'Sign in with your TAMU Google Account'
  visit new_payment_path
	select 'Venmo', :from => 'payment[payment_mtd]'
	select '2021', :from => 'payment_date_1i'
	select 'September', :from => 'payment_date_2i'
	select '1', :from => 'payment_date_3i'
	select 'one semester', :from => 'payment[membership_type]'
	select '2021', :from => 'payment_membership_expiration_1i'
	select 'December', :from => 'payment_membership_expiration_2i'
	select '31', :from => 'payment_membership_expiration_3i'
    fill_in 'payment_amount', with: '15'
    fill_in 'payment_member_uin', with: '111222333'
    select '999899799', :from => 'payment_officer_uin'
    click_on 'Create Payment'
	expect(page).to have_content("Payment was successfully created.")
    visit payments_path
    expect(page).to have_content('111222333')
	
  end
end


RSpec.describe 'Destroy payment', type: :feature do
  let!(:officer) { Officer.create(officer_uin: 987654321, name: 'Onam', email: 'e@tamu.edu', 
  amount_owed: 15) }
  let!(:member) { Member.create(member_uin: 123456789, first_name: 'Fnam', last_name: 'Lnam', 
  email: 'example@tamu.edu', phone_number: '1234567890', join_date: '1813-01-28') }
  let!(:payment) { Payment.create(payment_mtd: 'Cash', date: '2021/09/01', membership_type: 'one semester', 
  membership_expiration: '2021/12/31', amount: 15, member_uin: 123456789, officer_uin: 987654321) }
  
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end

  scenario 'successfully' do
  
    # A member has been created
    expect(Payment.count).to eq(1)
    visit payments_path
    click_link 'Sign in with your TAMU Google Account'
    visit payments_path
    expect(page).to have_content("2021-12-31")
    click_on 'Destroy'
    expect(page).to have_content('Payment was successfully destroyed.')
    expect(Payment.count).to eq(0)
  end
end


RSpec.describe 'Edit payment', type: :feature do
  let!(:officer) { Officer.create(officer_uin: 987654321, name: 'Onam', email: 'e@tamu.edu', 
  amount_owed: 15) }
  let!(:member) { Member.create(member_uin: 123456789, first_name: 'Fnam', last_name: 'Lnam', 
  email: 'example@tamu.edu', phone_number: '1234567890', join_date: '1813-01-28') }
  let!(:payment) { Payment.create(payment_mtd: 'Cash', date: '2021/09/01', membership_type: 'one semester', 
  membership_expiration: '2021/12/31', amount: 15, member_uin: 123456789, officer_uin: 987654321) }
  
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end

  scenario 'successfully' do
    
    # A payment has been created
    expect(Payment.count).to eq(1)
    visit payments_path
    click_link 'Sign in with your TAMU Google Account'
    visit payments_path
    expect(page).to have_content("Cash")
	expect(page).to have_content("123456789")
    click_on 'Edit'
	select 'Venmo', :from => 'payment[payment_mtd]'
	select '2021', :from => 'payment_date_1i'
	select 'September', :from => 'payment_date_2i'
	select '1', :from => 'payment_date_3i'
	select 'one semester', :from => 'payment[membership_type]'
	select '2021', :from => 'payment_membership_expiration_1i'
	select 'December', :from => 'payment_membership_expiration_2i'
	select '31', :from => 'payment_membership_expiration_3i'
    fill_in 'payment_amount', with: '15'
    fill_in 'payment_member_uin', with: '123456789'
    #select '987654321', :from => 'payment_officer_uin'
    click_on 'Update Payment'
    expect(page).to have_content('Payment was successfully updated.')
    expect(page).to have_content("Venmo")
    expect(page).to have_content("123456789")
  end
end
 
 
RSpec.describe 'Show payment', type: :feature do
  let!(:officer) { Officer.create(officer_uin: 987654321, name: 'Onam', email: 'e@tamu.edu', 
  amount_owed: 15) }
  let!(:member) { Member.create(member_uin: 123456789, first_name: 'Fnam', last_name: 'Lnam', 
  email: 'example@tamu.edu', phone_number: '1234567890', join_date: '1813-01-28') }
  let!(:payment) { Payment.create(payment_mtd: 'Cash', date: '2021/09/01', membership_type: 'one semester', 
  membership_expiration: '2021/12/31', amount: 15, member_uin: 123456789, officer_uin: 987654321) }
  
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end

  scenario 'successfully' do
  
    # A payment has been created
    expect(Payment.count).to eq(1)
    visit payments_path
    click_link 'Sign in with your TAMU Google Account'
    visit payments_path
    expect(page).to have_content("Cash")
    expect(page).to have_content("2021-09-01")
    expect(page).to have_content("123456789")
    click_on 'Show'
    expect(page).to have_content("Cash")
    expect(page).to have_content("2021-09-01")
    expect(page).to have_content("123456789")
  end
end
