# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create officer', type: :feature do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end

  let!(:officer) { Officer.create(officer_uin: '631009798', name: 'Yue Hu', email: 'yueh@tamu.edu', amount_owed: 0) }

  it 'empty UIN, name and email' do
    visit new_officer_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_officer_path
    click_on 'Create Officer'
    expect(page.has_content?("Officer UIN can't be blank")).to be(true)
    expect(page.has_content?("Name can't be blank")).to be(true)
    expect(page.has_content?("Email can't be blank")).to be(true)

    # No Officer record is created
    expect(Officer.count).to eq(1)
  end

  it 'valid inputs' do
    visit new_officer_path
    click_link 'Sign in with your TAMU Google Account'
    visit new_officer_path

    fill_in 'Officer UIN', with: 631_009_797
    fill_in 'Name', with: 'Yue'
    fill_in 'Email', with: 'yue@tamu.edu'
    click_on 'Create Officer'
    # An officer has been created
    expect(Officer.count).to eq(2)
    expect(page.has_content?('Officer was successfully created.')).to be(true)
    visit officers_path
    expect(page.has_content?('631009797')).to be(true)
    expect(page.has_content?('Yue')).to be(true)
    expect(page.has_content?('0')).to be(true)
    expect(page.has_content?('yue@tamu.edu')).to be(true)
  end

  it 'duplicated UIN and email' do
    visit new_officer_path
    click_link 'Sign in with your TAMU Google Account'
    Officer.create(officer_uin: 631_009_798, name: 'Yue Hu', email: 'yueh@tamu.edu', amount_owed: 0)
    # An officer has been created
    expect(Officer.count).to eq(1)
    visit officers_path
    expect(page.has_content?('631009798')).to be(true)
    expect(page.has_content?('Yue Hu')).to be(true)
    expect(page.has_content?('0')).to be(true)
    expect(page.has_content?('yueh@tamu.edu')).to be(true)
    visit new_officer_path
    fill_in 'Officer UIN', with: 631_009_798
    fill_in 'Name', with: 'Yuan Lisha'
    fill_in 'Email', with: 'yueh@tamu.edu'
    click_on 'Create Officer'
    expect(page.has_content?('Officer UIN has already been taken')).to be(true)
    expect(page.has_content?('Email has already been taken')).to be(true)
  end

  it 'destory officer' do
    # An officer has been created
    visit new_officer_path
    click_link 'Sign in with your TAMU Google Account'
    expect(Officer.count).to eq(1)
    visit officers_path
    expect(page.has_content?('631009798')).to be(true)
    expect(page.has_content?('Yue Hu')).to be(true)
    expect(page.has_content?('0')).to be(true)
    expect(page.has_content?('yueh@tamu.edu')).to be(true)
    click_on 'Delete'
    expect(page.has_content?('Officer was successfully destroyed.')).to be(true)
    expect(Officer.count).to eq(0)
  end

  it 'update officer' do
    # An officer has been created
    visit new_officer_path
    click_link 'Sign in with your TAMU Google Account'
    expect(Officer.count).to eq(1)
    visit officers_path
    expect(page.has_content?('631009798')).to be(true)
    expect(page.has_content?('Yue Hu')).to be(true)
    expect(page.has_content?('0')).to be(true)
    expect(page.has_content?('yueh@tamu.edu')).to be(true)
    click_on 'Edit'
    fill_in 'Officer UIN', with: 631_009_798
    fill_in 'Name', with: 'Yuan Lisha'
    fill_in 'Email', with: 'lisha@tamu.edu'

    click_on 'Update Officer'
    expect(page.has_content?('Officer was successfully updated.')).to be(true)
    expect(page.has_content?('631009798')).to be(true)
    expect(page.has_content?('Yuan Lisha')).to be(true)
    expect(page.has_content?('0')).to be(true)
    expect(page.has_content?('lisha@tamu.edu')).to be(true)
  end

  it 'fails because of duplication' do
    visit new_officer_path
    click_link 'Sign in with your TAMU Google Account'
    Officer.create(officer_uin: 6898, name: 'Lisha Yuan', email: 'lisha@tamu.edu', amount_owed: 0)

    expect(Officer.count).to eq(2)
    visit officers_path
    expect(page.has_content?('6898')).to be(true)
    page.find('tr', text: '6898').click_on 'Edit'
    fill_in 'Officer UIN', with: 631_009_798
    fill_in 'Name', with: 'Yuan Lisha'
    fill_in 'Email', with: 'lisha@tamu.edu'
    click_on 'Update Officer'
    expect(page.has_content?('Officer UIN has already been taken')).to be(true)
  end
end
