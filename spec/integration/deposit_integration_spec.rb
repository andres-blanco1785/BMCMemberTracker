require 'rails_helper'

RSpec.describe 'Create Deposit', type: :feature do
  scenario 'empty deposit ID, officer uin, transaction id, amount, and date' do
    visit new_deposit_path
    click_on 'Create Deposit'
    expect(page).to have_content("Deposit ID can't be blank")
    expect(page).to have_content("Officer UIN can't be blank")
    expect(page).to have_content("Transaction ID can't be blank")
    expect(page).to have_content("Amount can't be blank")
    expect(page).to have_content("Date can't be blank")


    # No member record is created
    expect(Member.count).to eq(0)
  end
end
