require 'rails_helper'

RSpec.describe 'create officer', type: :feature do
  scenario 'empty UIN, name and email' do
    visit new_officer_path
    click_on 'Create Officer'
    expect(page).to have_content("Officer UIN can't be blank")
    expect(page).to have_content("Officer UIN can't be blank")
    expect(page).to have_content("Officer UIN can't be blank")

    # No Officer record is created
    expect(Officer.count).to eq(0)
  end

  scenario 'valid inputs' do
    visit new_officer_path
    fill_in 'Officer UIN', with: 631009798
    fill_in 'Name', with: 'Yue Hu'
    fill_in 'Email', with: 'yueh@tamu.edu'
    fill_in 'Amount Owed', with: 0
    click_on 'Create Officer'
    # An officer has been created
    expect(Officer.count).to eq(1)
    expect(page).to have_content("Officer was successfully created.")
    visit officers_path
    expect(page).to have_content("631009798")
    expect(page).to have_content("Yue Hu")
    expect(page).to have_content("0")
    expect(page).to have_content("yueh@tamu.edu")

   
    
  end
end