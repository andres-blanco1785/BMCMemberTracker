require 'rails_helper'

RSpec.describe 'Create Deposit', type: :feature do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end
  scenario 'empty officer uin, category, amount, and date' do
    visit new_member_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_deposit_path
    # click_on 'New Deposit'
    click_on 'Create Deposit'
    expect(page).to have_content("Officer uin can't be blank")
    expect(page).to have_content("Category can't be blank")
    expect(page).to have_content("Amount can't be blank")
    # No deposit record is created
    expect(Deposit.count).to eq(0)
  end
end
#
#   scenario 'valid inputs' do
#     visit new_deposit_path
#     fill_in 'deposit_officer_uin', with: 100000000
#     fill_in 'deposit_category', with: 111
#     fill_in 'deposit_amount', with: 20
#     fill_in 'deposit_date', with: '2021-10-21'
#     click_on 'Create Deposit'
#     # An deposit has been created
#     expect(Deposit.count).to eq(1)
#     expect(page).to have_content("Deposit was successfully created.")
#     visit deposit_path
#     expect(page).to have_content("100000000")
#     expect(page).to have_content("111")
#     expect(page).to have_content("20")
#     expect(page).to have_content("2021-10-21")
#   end
# end
#
# RSpec.describe 'Destroy Deposit', type: :feature do
#   let!(:deposit) { Deposit.create(officer_uin: '111000123',
#     category: '111', amount: 100, date:"2021-10-21") }
#   scenario 'successfully' do
#     # An deposit has been created
#     expect(Deposit.count).to eq(1)
#     visit deposits_path
#     expect(page).to have_content("111000123")
#     expect(page).to have_content("111")
#     expect(page).to have_content("100")
#     expect(page).to have_content("2021-10-21")
#     click_on 'Destroy'
#     expect(page).to have_content('Deposit was successfully destroyed.')
#     expect(Deposit.count).to eq(0)
#   end
# end
#
#
#
# RSpec.describe 'Edit deposit', type: :feature do
#   let!(:deposit) { Deposit.create(officer_uin: '100000000',
#     category: '111', amount: 100, date:"2021-10-21") }
#   scenario 'successfully' do
#
#     # An deposit has been created
#     expect(Deposit.count).to eq(1)
#     visit deposits_path
#     expect(page).to have_content("100000000")
#     expect(page).to have_content("111")
#     expect(page).to have_content("100")
#     expect(page).to have_content("2021-10-21")
#     click_on 'Edit'
#     fill_in 'deposit_officer_uin', with: 100000000
#     fill_in 'deposit_category', with: 111
#     fill_in 'deposit_amount', with: 20
#     fill_in 'deposit_date', with: '2021-10-21'
#     click_on 'Update Deposit'
#     expect(page).to have_content("100000000")
#     expect(page).to have_content("111")
#     expect(page).to have_content("100")
#     expect(page).to have_content("2021-10-21")
#   end
# end
#
#
# RSpec.describe 'Show Deposit', type: :feature do
#   let!(:deposit) { Deposit.create(officer_uin: '100000000',
#     category: '111', amount: 100, date:"2021-10-21") }
#   scenario 'successfully' do
#     # An deposit has been created
#     expect(Deposit.count).to eq(1)
#     visit deposits_path
#     expect(page).to have_content("100000000")
#     expect(page).to have_content("111")
#     expect(page).to have_content("100")
#     expect(page).to have_content("2021-10-21")
#     click_on 'Show'
#     expect(page).to have_content("100000000")
#     expect(page).to have_content("111")
#     expect(page).to have_content("100")
#     expect(page).to have_content("2021-10-21")
#   end
# end
