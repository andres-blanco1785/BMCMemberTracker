# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create Member', type: :feature do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end

  it 'empty UIN, name, phone and email' do
    visit new_member_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_member_path
    click_on 'Create Member'
    expect(page.has_content?("Member uin can't be blank")).to be(true)
    expect(page.has_content?("First name can't be blank")).to be(true)
    expect(page.has_content?("Last name can't be blank")).to be(true)
    expect(page.has_content?("Email can't be blank")).to be(true)
    expect(page.has_content?("Phone number can't be blank")).to be(true)

    # No member record is created
    expect(Member.count).to eq(0)
  end

  it 'valid inputs' do
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
    expect(page.has_content?('Member was successfully created.')).to be(true)
    visit members_path
    expect(page.has_content?('727002594')).to be(true)
    expect(page.has_content?('Andres')).to be(true)
    expect(page.has_content?('Blanco')).to be(true)
    expect(page.has_content?('8326608665')).to be(true)
    expect(page.has_content?('andresblanco1785@tamu.edu')).to be(true)
  end

  it 'duplicated UIN and email' do
    Member.create(member_uin: '727002594', first_name: 'Andres', last_name: 'Blanco', email: 'andresblanco1785@tamu.edu', phone_number: '8326608665', join_date: '2021-10-03')
    # An member has been created
    expect(Member.count).to eq(1)
    visit members_path
    click_link 'Sign in with your TAMU Google Account'
    visit members_path
    expect(page.has_content?('727002594')).to be(true)
    expect(page.has_content?('Andres')).to be(true)
    expect(page.has_content?('Blanco')).to be(true)
    expect(page.has_content?('8326608665')).to be(true)
    expect(page.has_content?('andresblanco1785@tamu.edu')).to be(true)
    visit new_member_path
    fill_in 'member_member_uin', with: 727_002_594
    fill_in 'member_first_name', with: 'Justin Yoo'
    fill_in 'member_email', with: 'andresblanco1785@tamu.edu'
    fill_in 'member_phone_number', with: '8326608665'
    click_on 'Create Member'
    expect(page.has_content?('Member uin has already been taken')).to be(true)
    expect(page.has_content?('Email has already been taken')).to be(true)
  end
end

RSpec.describe 'Create invalid Member', type: :feature do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end

  it 'invalid inputs for UIN' do
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
    expect(Member.count).to eq(0) # because of previous scenario it will have made one
    visit members_path
    expect(page.has_content?('regularCharacters')).to be(false)
    expect(page.has_content?('Michael')).to be(false)
    expect(page.has_content?('Stewart')).to be(false)
    expect(page.has_content?('827')).to be(false)
    expect(page.has_content?('ms@tamu.edu')).to be(false)
  end
end

RSpec.describe 'Destroy Member', type: :feature do
  let!(:member) do
    Member.create(member_uin: '727002594', first_name: 'Andres', last_name: 'Blanco', email: 'andresblanco1785@tamu.edu',
                  phone_number: '8326608665', join_date: '2021-10-03')
  end

  it 'successfully' do
    # An member has been created
    expect(Member.count).to eq(1)
    visit members_path
    click_link 'Sign in with your TAMU Google Account'
    visit members_path
    expect(page.has_content?('727002594')).to be(true)
    expect(page.has_content?('Andres')).to be(true)
    expect(page.has_content?('Blanco')).to be(true)
    expect(page.has_content?('8326608665')).to be(true)
    expect(page.has_content?('andresblanco1785@tamu.edu')).to be(true)
    click_on 'Destroy'
    expect(page.has_content?('Member was successfully destroyed.')).to be(true)
    expect(Member.count).to eq(0)
  end
end

RSpec.describe 'Edit member', type: :feature do
  let!(:member) do
    Member.create(member_uin: '727002594', first_name: 'Andres', last_name: 'Blanco', email: 'andresblanco1785@tamu.edu',
                  phone_number: '8326608665', join_date: '2021-10-03')
  end

  it 'successfully' do
    # An member has been created
    expect(Member.count).to eq(1)
    visit members_path
    click_link 'Sign in with your TAMU Google Account'
    visit members_path
    expect(page.has_content?('727002594')).to be(true)
    expect(page.has_content?('Andres')).to be(true)
    expect(page.has_content?('Blanco')).to be(true)
    expect(page.has_content?('8326608665')).to be(true)
    expect(page.has_content?('andresblanco1785@tamu.edu')).to be(true)
    click_on 'Edit'
    fill_in 'member_member_uin', with: 727_002_594
    fill_in 'member_first_name', with: 'Pauline'
    fill_in 'member_last_name', with: 'Wade'
    fill_in 'member_email', with: 'paulinewade@tamu.edu'
    fill_in 'member_phone_number', with: '8326608665'
    click_on 'Update Member'
    expect(page.has_content?('Member was successfully updated.')).to be(true)
    expect(page.has_content?('727002594')).to be(true)
    expect(page.has_content?('Pauline')).to be(true)
    expect(page.has_content?('Wade')).to be(true)
    expect(page.has_content?('paulinewade@tamu.edu')).to be(true)
    expect(page.has_content?('8326608665')).to be(true)
  end
end

RSpec.describe 'Edit member incorrectly', type: :feature do
  let!(:member) do
    Member.create(member_uin: '827', first_name: 'Michael', last_name: 'Stewart', email: 'ms@tamu.edu',
                  phone_number: '832', join_date: '2021-10-03')
  end

  it 'successfully' do
    # An member has been created
    expect(Member.count).to eq(1)
    visit members_path
    click_link 'Sign in with your TAMU Google Account'
    visit members_path
    expect(page.has_content?('827')).to be(true)
    expect(page.has_content?('Michael')).to be(true)
    expect(page.has_content?('Stewart')).to be(true)
    expect(page.has_content?('832')).to be(true)
    expect(page.has_content?('ms@tamu.edu')).to be(true)
    click_on 'Edit'
    fill_in 'member_member_uin', with: 'hh'
    fill_in 'member_first_name', with: 'Pauline'
    fill_in 'member_last_name', with: 'Wade'
    fill_in 'member_email', with: 'paulinewade@tamu.edu'
    fill_in 'member_phone_number', with: '8326608665'
    click_on 'Update Member'
    visit members_path
    expect(page.has_content?('Member was successfully updated.')).to be(false)
    expect(page.has_content?('hh')).to be(false)
    expect(page.has_content?('Pauline')).to be(false)
    expect(page.has_content?('Wade')).to be(false)
    expect(page.has_content?('paulinewade@tamu.edu')).to be(false)
    expect(page.has_content?('8326608665')).to be(false)
  end
end

RSpec.describe 'Show Member', type: :feature do
  let!(:member) do
    Member.create(member_uin: '727002594', first_name: 'Andres', last_name: 'Blanco', email: 'andresblanco1785@tamu.edu',
                  phone_number: '8326608665', join_date: '2021-10-03')
  end

  it 'successfully' do
    # An member has been created
    expect(Member.count).to eq(1)
    visit members_path
    click_link 'Sign in with your TAMU Google Account'
    visit members_path
    expect(page.has_content?('727002594')).to be(true)
    expect(page.has_content?('Andres')).to be(true)
    expect(page.has_content?('Blanco')).to be(true)
    expect(page.has_content?('8326608665')).to be(true)
    expect(page.has_content?('andresblanco1785')).to be(true)
    click_on 'Show'
    expect(page.has_content?('727002594')).to be(true)
    expect(page.has_content?('Andres')).to be(true)
    expect(page.has_content?('Blanco')).to be(true)
    expect(page.has_content?('8326608665')).to be(true)
    expect(page.has_content?('andresblanco1785')).to be(true)
  end
end
