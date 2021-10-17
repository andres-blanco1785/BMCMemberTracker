require 'rails_helper'

RSpec.describe 'Create officer', type: :feature do
  scenario 'empty UIN, name and email' do
    visit new_officer_path
    click_on 'Create Officer'
    expect(page).to have_content("Officer UIN can't be blank")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Email can't be blank")

    # No Officer record is created
    expect(Officer.count).to eq(0)
  end

  scenario 'valid inputs' do
    visit new_officer_path
    fill_in 'Officer UIN', with: 631009798
    fill_in 'Name', with: 'Yue Hu'
    fill_in 'Email', with: 'yueh@tamu.edu'
    fill_in 'officer_amount_owed', with: 0
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
  scenario 'duplicated UIN and email' do
    Officer.create(officer_id: 631009798, name:'Yue Hu',email: 'yueh@tamu.edu',amount_owed:0)
    # An officer has been created
    expect(Officer.count).to eq(1)
    visit officers_path
    expect(page).to have_content("631009798")
    expect(page).to have_content("Yue Hu")
    expect(page).to have_content("0")
    expect(page).to have_content("yueh@tamu.edu") 
    visit new_officer_path
    fill_in 'Officer UIN', with: 631009798
    fill_in 'Name', with: 'Yuan Lisha'
    fill_in 'Email', with: 'yueh@tamu.edu'
    fill_in 'officer_amount_owed', with: 0
    click_on 'Create Officer'
    expect(page).to have_content('Officer UIN has already been taken')
    expect(page).to have_content('Email has already been taken')


  end
end

RSpec.describe 'Destroy officer', type: :feature do
  let!(:officer) { Officer.create(officer_id: '631009798', name: 'Yue Hu', email:'yueh@tamu.edu', amount_owed:0) }
  scenario 'successfully' do
    # An officer has been created
    expect(Officer.count).to eq(1)
    visit officers_path
    expect(page).to have_content("631009798")
    expect(page).to have_content("Yue Hu")
    expect(page).to have_content("0")
    expect(page).to have_content("yueh@tamu.edu") 
    click_on 'Destroy'
    expect(page).to have_content('Officer was successfully destroyed.')
    expect(Officer.count).to eq(0)
  end
end



RSpec.describe 'Edit officer', type: :feature do
  let!(:officer) { Officer.create(officer_id: '631009798', name: 'Yue Hu', email:'yueh@tamu.edu', amount_owed:0) }
  scenario 'successfully' do
    
    # An officer has been created
    expect(Officer.count).to eq(1)
    visit officers_path
    expect(page).to have_content("631009798")
    expect(page).to have_content("Yue Hu")
    expect(page).to have_content("0")
    expect(page).to have_content("yueh@tamu.edu") 
    click_on 'Edit'
    fill_in 'Officer UIN', with: 631009798
    fill_in 'Name', with: 'Yuan Lisha'
    fill_in 'Email', with: 'lisha@tamu.edu'
    fill_in 'officer_amount_owed', with: 0
    click_on 'Update Officer'
    expect(page).to have_content('Officer was successfully updated.')
    expect(page).to have_content("631009798")
    expect(page).to have_content("Yuan Lisha")
    expect(page).to have_content("0")
    expect(page).to have_content("lisha@tamu.edu") 
  end

  scenario 'fails because of duplication' do
    Officer.create(officer_id: 6898, name:'Lisha Yuan',email: 'lisha@tamu.edu',amount_owed:0)

    expect(Officer.count).to eq(2)
    visit officers_path
    expect(page).to have_content("6898")
    page.find('tr', text: '6898').click_on 'Edit'
    fill_in 'Officer UIN', with: 631009798
    fill_in 'Name', with: 'Yuan Lisha'
    fill_in 'Email', with: 'lisha@tamu.edu'
    fill_in 'officer_amount_owed', with: 0
    click_on 'Update Officer'
    expect(page).to have_content('Officer UIN has already been taken')
  end
end


RSpec.describe 'Show officer', type: :feature do
  let!(:officer) { Officer.create(officer_id: '631009798', name: 'Yue Hu', email:'yueh@tamu.edu', amount_owed:0) }
  scenario 'successfully' do
    # An officer has been created
    expect(Officer.count).to eq(1)
    visit officers_path
    expect(page).to have_content("631009798")
    expect(page).to have_content("Yue Hu")
    expect(page).to have_content("0")
    expect(page).to have_content("yueh@tamu.edu") 
    click_on 'Show'
    expect(page).to have_content("631009798")
    expect(page).to have_content("Yue Hu")
    expect(page).to have_content("0")
    expect(page).to have_content("yueh@tamu.edu") 
  end
end



