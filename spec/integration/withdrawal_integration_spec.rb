require 'rails_helper'

RSpec.describe 'Create withdrawal', type: :feature do
  let!(:officer) { Officer.create(officer_uin: '631009798', 
      name: 'Yue Hu', email:'yueh@tamu.edu', amount_owed:0) }
  let!(:transaction_type) { TransactionType.create(category: 'party') }
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end
  scenario 'empty officer, category, amount' do
    visit new_withdrawal_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_withdrawal_path
    click_on 'Create Withdrawal'
    expect(page).to have_content("Officer uin can't be blank")
    expect(page).to have_content("Category can't be blank")
    expect(page).to have_content("Amount can't be blank")

    # No Officer record is created
    expect(Withdrawal.count).to eq(0)
  end

  scenario 'valid inputs' do
    
    visit new_withdrawal_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_withdrawal_path
    click_on 'Create Withdrawal'

    fill_in 'Officer UIN', with: 631009798
    select "party", :from => 'withdrawal_category'
    fill_in 'Amount', with: 10
    fill_in 'withdrawal_title', with: "happy hour"
    fill_in 'Description', with: "Just drink and dance"
    click_on 'Create Withdrawal'
    # An officer has been created
    expect(Withdrawal.count).to eq(1)
    expect(page).to have_content("Withdrawal was successfully created.")
    visit withdrawals_path
    expect(page).to have_content("631009798")
    expect(page).to have_content("party")
    expect(page).to have_content("10")
    expect(page).to have_content("happy hour")   
    expect(page).to have_content("Just drink and dance")   
  end

end

RSpec.describe 'Destroy Withdrawal', type: :feature do
  let!(:officer) { Officer.create(officer_uin: '631009798', 
      name: 'Yue Hu', email:'yueh@tamu.edu', amount_owed:0) }
  let!(:transaction_type) { TransactionType.create(category: 'party') }
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end
  scenario 'Destroy successfully' do
    visit new_withdrawal_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_withdrawal_path
    click_on 'Create Withdrawal'
    fill_in 'Officer UIN', with: 631009798
    select "party", :from => 'withdrawal_category'
    fill_in 'Amount', with: 10
    fill_in 'withdrawal_title', with: "happy hour"
    fill_in 'Description', with: "Just drink and dance"
    click_on 'Create Withdrawal'
    # An Withdrawal has been created
    expect(Withdrawal.count).to eq(1)


    visit withdrawals_path
    click_on 'Destroy'
    expect(page).to have_content('Withdrawal was successfully destroyed.')
    expect(Withdrawal.count).to eq(0)
  end
end



RSpec.describe 'Edit Withdrawal', type: :feature do
  let!(:officer) { Officer.create(officer_uin: '631009798', 
      name: 'Yue Hu', email:'yueh@tamu.edu', amount_owed:0) }
  let!(:transaction_type) { TransactionType.create(category: 'party') }
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end
  scenario 'Successfully' do
    visit new_withdrawal_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_withdrawal_path
    click_on 'Create Withdrawal'
    fill_in 'Officer UIN', with: 631009798
    select "party", :from => 'withdrawal_category'
    fill_in 'Amount', with: 10
    fill_in 'withdrawal_title', with: "happy hour"
    fill_in 'Description', with: "Just drink and dance"
    click_on 'Create Withdrawal'
    # An Withdrawal has been created
    expect(Withdrawal.count).to eq(1)


    visit withdrawals_path
    click_on 'Edit'
    fill_in 'Officer UIN', with: 631009798
    select "party", :from => 'withdrawal_category'
    fill_in 'Amount', with: 100
    fill_in 'withdrawal_title', with: "happy hour111"
    fill_in 'Description', with: "Just drink and dance111"
    click_on 'Update Withdrawal'
    expect(page).to have_content("Withdrawal was successfully updated")
    expect(page).to have_content("100")
    expect(page).to have_content("happy hour111")   
    expect(page).to have_content("Just drink and dance111") 

  end
 
end


RSpec.describe 'Show Withdrawal', type: :feature do
  let!(:officer) { Officer.create(officer_uin: '631009798', 
      name: 'Yue Hu', email:'yueh@tamu.edu', amount_owed:0) }
  let!(:transaction_type) { TransactionType.create(category: 'party') }
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end



  scenario 'successfully' do

    visit new_withdrawal_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_withdrawal_path
    click_on 'Create Withdrawal'
    fill_in 'Officer UIN', with: 631009798
    select "party", :from => 'withdrawal_category'
    fill_in 'Amount', with: 10
    fill_in 'withdrawal_title', with: "happy hour"
    fill_in 'Description', with: "Just drink and dance"
    click_on 'Create Withdrawal'
    # An Withdrawal has been created
    expect(Withdrawal.count).to eq(1)
    visit withdrawals_path
    click_on 'Show'
    expect(page).to have_content("631009798")
    expect(page).to have_content("party")
    expect(page).to have_content("10")
    expect(page).to have_content("happy hour")   
    expect(page).to have_content("Just drink and dance") 
  end
end