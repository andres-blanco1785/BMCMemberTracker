require 'rails_helper'
#  login --> create 3 members --> create 2 officers --> create 3 payment methods
#  --> create 3 payments --> modify payments --> create 2 deposits 
#  --> create 2 withdrawals
RSpec.describe 'Create all entities using the UI', type: :feature do
  # mock login
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end

  it 'create all successfully' do
    # Now create members
    visit new_member_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_member_path
    fill_in "UIN / Driver's License", with: '100000000'
    fill_in 'First Name', with: 'Alexandria'
    fill_in 'Last Name', with: 'Curtis'
    fill_in 'Email', with: 'acurtis55@tamu.edu'
    fill_in 'Phone Number', with: '5125207373'
    click_on 'Create Member'
    # An member has been created
    expect(Member.count).to eq(1)

    visit new_member_path
    fill_in "UIN / Driver's License", with: '631009798'
    fill_in 'First Name', with: 'Yue'
    fill_in 'Last Name', with: 'Hu'
    fill_in 'Email', with: 'yueh@tamu.edu'
    fill_in 'Phone Number', with: '5409983608'
    click_on 'Create Member'
    # Two members have been created
    expect(Member.count).to eq(2)

    visit new_member_path
    fill_in "UIN / Driver's License", with: '727002594'
    fill_in 'First Name', with: 'Andres'
    fill_in 'Last Name', with: 'Blanco'
    fill_in 'Email', with: 'andresblanco1785@tamu.edu'
    fill_in 'Phone Number', with: '8326608665'
    click_on 'Create Member'
    # Three members have been created
    expect(Member.count).to eq(3)

    visit members_path
    expect(page.has_content?('100000000')).to be(true)
    expect(page.has_content?('Alexandria')).to be(true)
    expect(page.has_content?('Curtis')).to be(true)
    expect(page.has_content?('5125207373')).to be(true)
    expect(page.has_content?('acurtis55@tamu.edu')).to be(true)

    # now create 2 officers
    visit new_officer_path
    fill_in 'Officer UIN', with: '631009798'
    fill_in 'Name', with: 'Yue Hu'
    fill_in 'Email', with: 'yueh@tamu.edu'
    click_on 'Create Officer'
    # An officer has been created
    expect(Officer.count).to eq(1)

    visit new_officer_path
    fill_in 'Officer UIN', with: '90999099'
    fill_in 'Name', with: 'Michael Stewart'
    fill_in 'Email', with: 'justin@tamu.edu'
    click_on 'Create Officer'
    # Two officers have been created
    expect(Officer.count).to eq(2)

    visit officers_path
    expect(page.has_content?('90999099')).to be(true)
    expect(page.has_content?('0')).to be(true)
    expect(page.has_content?('Michael Stewart')).to be(true)
    expect(page.has_content?('justin@tamu.edu')).to be(true)

    # now create 3 payment methods
    visit new_payment_method_path
    fill_in 'Method', with: 'Cash'
    click_on 'Create Payment method'
    visit new_payment_method_path
    fill_in 'Method', with: 'Paypal'
    click_on 'Create Payment method'
    visit new_payment_method_path
    fill_in 'Method', with: 'Venmo'
    click_on 'Create Payment method'
    expect(PaymentMethod.count).to eq(3)

    #now create 3 payments
    visit new_payment_path
    fill_in 'Amount', with: '15'
    fill_in 'Member uin', with: '100000000'
    select 'Yue Hu', from: 'payment_officer_uin'
    select 'Cash', from: 'payment[method]'
    click_on 'Create Payment'
    expect(page.has_content?('Payment was successfully created.')).to be(true)
    visit payments_path
    expect(page.has_content?('Alexandria Curtis')).to be(true)
    expect(Payment.count).to eq(1)

    visit new_payment_path
    fill_in 'Amount', with: '25'
    fill_in 'Member uin', with: '631009798'
    select 'Michael Stewart', from: 'payment_officer_uin'
    select 'Venmo', from: 'payment[method]'
    click_on 'Create Payment'
    expect(page.has_content?('Payment was successfully created.')).to be(true)
    visit payments_path
    expect(page.has_content?('Yue Hu')).to be(true)
    expect(Payment.count).to eq(2)

    visit new_payment_path
    fill_in 'Amount', with: '50'
    fill_in 'Member uin', with: '727002594'
    select 'Michael Stewart', from: 'payment_officer_uin'
    select 'Paypal', from: 'payment[method]'
    click_on 'Create Payment'
    expect(page.has_content?('Payment was successfully created.')).to be(true)
    visit payments_path
    expect(page.has_content?('Yue Hu')).to be(true)
    expect(Payment.count).to eq(3)

    #Yue has 15 amount owed, Michael has 75 amount owed
    visit officers_path
    expect(page.has_content?('75')).to be(true)
    expect(page.has_content?('15')).to be(true)

    #Make the second payment to Yue, change the third payment amount as 90  
    visit payments_path
    find(:xpath, "//tr[td[contains(.,'25')]]/td/a", :text => 'Edit').click
    select 'Yue Hu', from: 'payment_officer_uin'
    click_on('Update Payment')
    visit officers_path
    expect(page.has_content?('40')). to be(true)
    expect(page.has_content?('50')). to be(true)
    visit payments_path
    find(:xpath, "//tr[td[contains(.,'Michael Stewart')]]/td/a", :text => 'Edit').click
    fill_in 'Amount', with: '90'
    click_on('Update Payment')
    visit officers_path
    expect(page.has_content?('90')). to be(true)
    expect(page.has_content?('40')). to be(true)
    
  end

  # it 'valid inputs' do
  #   visit new_member_path
  #   click_link 'Sign in with your TAMU Google Account'
  #   visit new_deposit_path
  #   fill_in 'deposit_officer_uin', with: 100_000_000
  #   select 'Venmo', from: 'deposit[category]'
  #   fill_in 'deposit_amount', with: 20
  #   select '2021', from: 'deposit_date_1i'
  #   select 'December', from: 'deposit_date_2i'
  #   select '31', from: 'deposit_date_3i'
  #   click_on 'Create Deposit'
  #   # An deposit has been created
  #   expect(Deposit.count).to eq(2)
  #   expect(page.has_content?('Deposit was successfully created.')).to be(true)
  #   visit deposits_path
  #   expect(page.has_content?('111000123')).to be(true)
  #   expect(page.has_content?('Venmo')).to be(true)
  #   expect(page.has_content?('20')).to be(true)
  #   expect(page.has_content?('2021-10-21')).to be(true)
  # end

  # it 'destory deposit' do
  #   # An deposit has been created
  #   visit new_member_path
  #   click_link 'Sign in with your TAMU Google Account'
  #   visit new_deposit_path
  #   expect(Deposit.count).to eq(1)
  #   visit deposits_path
  #   expect(page.has_content?('111000123')).to be(true)
  #   expect(page.has_content?('Venmo')).to be(true)
  #   expect(page.has_content?('100')).to be(true)
  #   expect(page.has_content?('2021-10-21')).to be(true)
  #   click_on 'Destroy'
  #   expect(page.has_content?('Deposit was successfully destroyed.')).to be(true)
  #   expect(Deposit.count).to eq(0)
  # end

  # it 'update deposit' do
  #   visit new_member_path
  #   click_link 'Sign in with your TAMU Google Account'
  #   visit new_deposit_path
  #   expect(Deposit.count).to eq(1)
  #   visit deposits_path
  #   expect(page.has_content?('111000123')).to be(true)
  #   expect(page.has_content?('Venmo')).to be(true)
  #   expect(page.has_content?('100')).to be(true)
  #   expect(page.has_content?('2021-10-21')).to be(true)
  #   click_on 'Edit'
  #   fill_in 'deposit_officer_uin', with: 100_000_001
  #   fill_in 'deposit_amount', with: 200
  #   select '2021', from: 'deposit_date_1i'
  #   select 'December', from: 'deposit_date_2i'
  #   select '31', from: 'deposit_date_3i'
  #   click_on 'Update Deposit'
  #   expect(page.has_content?('100000001')).to be(true)
  #   expect(page.has_content?('Venmo')).to be(true)
  #   expect(page.has_content?('200')).to be(true)
  #   expect(page.has_content?('2021-12-31')).to be(true)
  # end

  # it 'show deposit' do
  #   visit new_member_path
  #   click_link 'Sign in with your TAMU Google Account'
  #   visit new_deposit_path
  #   expect(Deposit.count).to eq(1)
  #   visit deposits_path
  #   expect(page.has_content?('111000123')).to be(true)
  #   expect(page.has_content?('Venmo')).to be(true)
  #   expect(page.has_content?('100')).to be(true)
  #   expect(page.has_content?('2021-10-21')).to be(true)
  #   click_on 'Show'
  #   expect(page.has_content?('111000123')).to be(true)
  #   expect(page.has_content?('Venmo')).to be(true)
  #   expect(page.has_content?('100')).to be(true)
  #   expect(page.has_content?('2021-10-21')).to be(true)
  # end
end
