require 'rails_helper'

RSpec.feature "testing oauth" do
    before do
        Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
        Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
    end

    scenario 'root page (members#index) should redirect to sign in page if not signed in' do
        visit root_path
        
        expect(page).to have_current_path('/admins/sign_in')
        expect(page).to have_content('Welcome to the Texas A&M Badminton Club.')
        expect(page).to have_link("Sign in with your TAMU Google Account")
    end

    scenario 'officers#index should redirect to sign in page if not signed in' do
        visit officers_path

        expect(page).to have_current_path('/admins/sign_in')
        expect(page).to have_content('Welcome to the Texas A&M Badminton Club.')
        expect(page).to have_link("Sign in with your TAMU Google Account")
    end

    scenario 'payments#index should redirect to sign in page if not signed in' do
        visit payments_path

        expect(page).to have_current_path('/admins/sign_in')
        expect(page).to have_content('Welcome to the Texas A&M Badminton Club.')
        expect(page).to have_link("Sign in with your TAMU Google Account")
    end

    scenario 'visit root page, sign in w/valid credentials, and redirect to root path' do
        visit root_path

        expect(page).to have_link('Sign in with your TAMU Google Account')
        click_link 'Sign in with your TAMU Google Account'

        expect(page).to have_content('Successfully authenticated from Google account.')
        expect(page).to have_current_path(root_path)
    end

    # scenario 'visit payments page, sign in w/valid credentials, and redirect to root path' do
    #     visit payments_path

    #     expect(page).to have_link('Sign in with your TAMU Google Account')
    #     click_link 'Sign in with your TAMU Google Account'

    #     expect(page).to have_content('Successfully authenticated from Google account.')
    #     expect(page).to have_current_path('/payments')
    # end

    # scenario 'visit officers page, sign in w/valid credentials, and redirect to root path' do
    #     visit officers_path

    #     expect(page).to have_link('Sign in with your TAMU Google Account')
    #     click_link 'Sign in with your TAMU Google Account'

    #     expect(page).to have_content('Successfully authenticated from Google account.')
    #     expect(page).to have_current_path('/officers')
    # end

    scenario 'signing out redirects to sign in page' do
        visit root_path

        click_link 'Sign in with your TAMU Google Account'
        click_link 'Sign Out'

        expect(page).to have_content('Signed out successfully.')
    end
end