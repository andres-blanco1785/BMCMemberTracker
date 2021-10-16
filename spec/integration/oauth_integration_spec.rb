require 'rails_helper'

RSpec.feature "testing oauth" do
    before do
        Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
        Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
    end

    scenario "should reach member page after logging in" do
        visit root_path
        
        expect(page).to have_link("Sign in with your TAMU Google Account")
        click_link "Sign in with your TAMU Google Account"

        expect(page).to have_content("Successfully authenticated from Google account.")
    end
end