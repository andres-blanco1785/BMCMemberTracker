# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'testing oauth' do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end

  it 'root page (members#index) should redirect to sign in page if not signed in' do
    visit root_path

    expect(page.has_current_path?('/admins/sign_in')).to be(true)
    expect(page.has_content?('Welcome to the Texas A&M Badminton Club.')).to be(true)
    expect(page.has_link?('Sign in with your TAMU Google Account')).to be(true)
  end

  it 'officers#index should redirect to sign in page if not signed in' do
    visit officers_path

    expect(page.has_current_path?('/admins/sign_in')).to be(true)
    expect(page.has_content?('Welcome to the Texas A&M Badminton Club.')).to be(true)
    expect(page.has_link?('Sign in with your TAMU Google Account')).to be(true)
  end

  it 'payments#index should redirect to sign in page if not signed in' do
    visit payments_path

    expect(page.has_current_path?('/admins/sign_in')).to be(true)
    expect(page.has_content?('Welcome to the Texas A&M Badminton Club.')).to be(true)
    expect(page.has_link?('Sign in with your TAMU Google Account')).to be(true)
  end

  it 'visit root page, sign in w/valid credentials, and redirect to root path' do
    visit root_path

    expect(page.has_link?('Sign in with your TAMU Google Account')).to be(true)
    click_link 'Sign in with your TAMU Google Account'

    expect(page.has_content?('Successfully authenticated from Google account.')).to be(true)
    expect(page.has_current_path?(root_path)).to be(true)
  end

  it 'visit payments page, sign in w/valid credentials, and redirect to root path' do
    visit payments_path

    expect(page.has_link?('Sign in with your TAMU Google Account')).to be(true)
    click_link 'Sign in with your TAMU Google Account'

    expect(page.has_content?('Successfully authenticated from Google account.')).to be(true)
    visit payments_path
    expect(page.has_current_path?('/payments')).to be(true)
  end

  it 'visit officers page, sign in w/valid credentials, and redirect to root path' do
    visit officers_path

    expect(page.has_link?('Sign in with your TAMU Google Account')).to be(true)
    click_link 'Sign in with your TAMU Google Account'

    expect(page.has_content?('Successfully authenticated from Google account.')).to be(true)
    visit officers_path
    expect(page.has_current_path?('/officers')).to be(true)
  end

  it 'signing out redirects to sign in page' do
    visit root_path

    click_link 'Sign in with your TAMU Google Account'
    click_link 'Sign Out'

    expect(page.has_content?('Signed out successfully.')).to be(true)
  end
end
