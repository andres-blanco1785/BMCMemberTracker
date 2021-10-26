require 'rails_helper'

RSpec.describe 'Create Member', type: :feature do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end
  scenario 'empty UIN, name, phone and email' do
    visit new_member_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_member_path
    click_on 'Create Member'
    expect(page).to have_content("Member uin can't be blank")
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Phone number can't be blank")


    # No member record is created
    expect(Member.count).to eq(0)
  end

  scenario 'valid inputs' do
    visit new_member_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_member_path
    fill_in 'UIN', with: '727002594'
    fill_in 'First Name', with: 'Andres'
    fill_in 'Last Name', with: 'Blanco'
    fill_in 'Email', with: 'andresblanco1785@tamu.edu'
    fill_in 'Phone Number', with: '8326608665'
    click_on 'Create Member'
    # An member has been created
    expect(Member.count).to eq(1)
    expect(page).to have_content("Member was successfully created.")
    visit members_path
    expect(page).to have_content("727002594")
    expect(page).to have_content("Andres")
    expect(page).to have_content("Blanco")
    expect(page).to have_content("8326608665")
    expect(page).to have_content("andresblanco1785@tamu.edu")   
  end
  scenario 'duplicated UIN and email' do
    Member.create(member_uin: "727002594", first_name: 'Andres', last_name: 'Blanco', email: 'andresblanco1785@tamu.edu',
    phone_number: "8326608665", join_date: "2021-10-03")
    # An member has been created
    expect(Member.count).to eq(1)
    visit members_path
    click_link 'Sign in with your TAMU Google Account'
    visit members_path
    expect(page).to have_content("727002594")
    expect(page).to have_content("Andres")
    expect(page).to have_content("Blanco")
    expect(page).to have_content("8326608665")
    expect(page).to have_content("andresblanco1785@tamu.edu") 
    visit new_member_path
    fill_in 'member_member_uin', with: 727002594
    fill_in 'member_first_name', with: 'Justin Yoo'
    fill_in 'member_email', with: 'andresblanco1785@tamu.edu'
    fill_in 'member_phone_number', with: '8326608665'
    click_on 'Create Member'
    expect(page).to have_content('Member uin has already been taken')
    expect(page).to have_content('Email has already been taken')
  end
end

RSpec.describe 'Create invalid Member', type: :feature do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end

  scenario 'invalid inputs for UIN' do
    visit new_member_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_member_path
    fill_in 'UIN', with: 'regularCharacters'
    fill_in 'First Name', with: 'Michael'
    fill_in 'Last Name', with: 'Stewart'
    fill_in 'Email', with: 'ms@tamu.edu'
    fill_in 'Phone Number', with: '827'
    click_on 'Create Member'
    # An member has been created
    expect(Member.count).to eq(0) #because of previous scenario it will have made one 
    visit members_path
    expect(page).not_to have_content("regularCharacters")
    expect(page).not_to have_content("Michael")
    expect(page).not_to have_content("Stewart")
    expect(page).not_to have_content("827")
    expect(page).not_to have_content("ms@tamu.edu")
  end
end



RSpec.describe 'Destroy Member', type: :feature do
  let!(:member) { Member.create(member_uin: "727002594", first_name: 'Andres', last_name: 'Blanco', email: 'andresblanco1785@tamu.edu',
  phone_number: "8326608665", join_date: "2021-10-03") }
  scenario 'successfully' do
    # An member has been created
    expect(Member.count).to eq(1)
    visit members_path
    click_link 'Sign in with your TAMU Google Account'
    visit members_path
    expect(page).to have_content("727002594")
    expect(page).to have_content("Andres")
    expect(page).to have_content("Blanco")
    expect(page).to have_content("8326608665")
    expect(page).to have_content("andresblanco1785@tamu.edu") 
    click_on 'Destroy'
    expect(page).to have_content('Member was successfully destroyed.')
    expect(Member.count).to eq(0)
  end
end



RSpec.describe 'Edit member', type: :feature do
  let!(:member) { Member.create(member_uin: "727002594", first_name: 'Andres', last_name: 'Blanco', email: 'andresblanco1785@tamu.edu',
  phone_number: "8326608665", join_date: "2021-10-03") }
  scenario 'successfully' do
    
    # An member has been created
    expect(Member.count).to eq(1)
    visit members_path
    click_link 'Sign in with your TAMU Google Account'
    visit members_path
    expect(page).to have_content("727002594")
    expect(page).to have_content("Andres")
    expect(page).to have_content("Blanco")
    expect(page).to have_content("8326608665")
    expect(page).to have_content("andresblanco1785@tamu.edu") 
    click_on 'Edit'
    fill_in 'member_member_uin', with: 727002594
    fill_in 'member_first_name', with: 'Pauline'
    fill_in 'member_last_name', with: 'Wade'
    fill_in 'member_email', with: 'paulinewade@tamu.edu'
    fill_in 'member_phone_number', with: "8326608665"
    click_on 'Update Member'
    expect(page).to have_content('Member was successfully updated.')
    expect(page).to have_content("727002594")
    expect(page).to have_content("Pauline")
    expect(page).to have_content("Wade")
    expect(page).to have_content("paulinewade@tamu.edu")
    expect(page).to have_content("8326608665") 
  end
end

RSpec.describe 'Edit member incorrectly', type: :feature do
  let!(:member) { Member.create(member_uin: "827", first_name: 'Michael', last_name: 'Stewart', email: 'ms@tamu.edu',
  phone_number: "832", join_date: "2021-10-03") }
  scenario 'successfully' do
    
    # An member has been created
    expect(Member.count).to eq(1)
    visit members_path
    click_link 'Sign in with your TAMU Google Account'
    visit members_path
    expect(page).to have_content("827")
    expect(page).to have_content("Michael")
    expect(page).to have_content("Stewart")
    expect(page).to have_content("832")
    expect(page).to have_content("ms@tamu.edu") 
    click_on 'Edit'
    fill_in 'member_member_uin', with: 'hh'
    fill_in 'member_first_name', with: 'Pauline'
    fill_in 'member_last_name', with: 'Wade'
    fill_in 'member_email', with: 'paulinewade@tamu.edu'
    fill_in 'member_phone_number', with: "8326608665"
    click_on 'Update Member'
    visit members_path
    expect(page).not_to have_content('Member was successfully updated.')
    expect(page).not_to have_content("hh")
    expect(page).not_to have_content("Pauline")
    expect(page).not_to have_content("Wade")
    expect(page).not_to have_content("paulinewade@tamu.edu")
    expect(page).not_to have_content("8326608665") 
  end
end


RSpec.describe 'Show Member', type: :feature do
  let!(:member) { Member.create(member_uin: "727002594", first_name: 'Andres', last_name: 'Blanco', email: 'andresblanco1785@tamu.edu',
  phone_number: "8326608665", join_date: "2021-10-03") }
  scenario 'successfully' do
    # An member has been created
    expect(Member.count).to eq(1)
    visit members_path
    click_link 'Sign in with your TAMU Google Account'
    visit members_path
    expect(page).to have_content("727002594")
    expect(page).to have_content("Andres")
    expect(page).to have_content("Blanco")
    expect(page).to have_content("8326608665")
    expect(page).to have_content("andresblanco1785") 
    click_on 'Show'
    expect(page).to have_content("727002594")
    expect(page).to have_content("Andres")
    expect(page).to have_content("Blanco")
    expect(page).to have_content("8326608665")
    expect(page).to have_content("andresblanco1785") 
  end
end



