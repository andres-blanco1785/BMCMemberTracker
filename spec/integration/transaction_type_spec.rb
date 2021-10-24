require 'rails_helper'

RSpec.describe 'Create TransactionType', type: :feature do
    before do
        Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
        Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
    end

    scenario 'empty category' do
        visit new_transaction_type_path

        # need to sign in before doing testing
        click_link 'Sign in with your TAMU Google Account'

        visit new_transaction_type_path
        expect(page).to have_current_path('/transaction_types/new')

        click_on 'Create Transaction type'

        expect(page).to have_content("Category can't be blank")

        # No transaction type record is created
        expect(Member.count).to eq(0)
    end

    scenario 'valid inputs' do
        visit new_transaction_type_path

        # need to sign in before visiting any path and doing testing
        click_link 'Sign in with your TAMU Google Account'

        visit new_transaction_type_path
        fill_in 'Category', with: 'Test Category'
        click_on 'Create Transaction type'

        # A transaction type has been created
        expect(TransactionType.count).to eq(1)
        expect(page).to have_content("Transaction type was successfully created.")
        visit transaction_types_path
        expect(page).to have_content("Test Category")
    end

    scenario 'duplicated category' do
        visit transaction_types_path

        # need to sign in before visiting any path and doing testing
        click_link 'Sign in with your TAMU Google Account'

        TransactionType.create(category: "Test Category")

        # A member has been created
        expect(TransactionType.count).to eq(1)
        visit transaction_types_path
        expect(page).to have_content("Test Category")

        visit new_transaction_type_path
        fill_in 'Category', with: 'Test Category'
        click_on 'Create Transaction type'
        expect(page).to have_content('Category has already been taken')
    end
end

RSpec.describe 'Destroy TransactionType', type: :feature do
    before do
        Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
        Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
    end
    
    # Create mock Transaction Type object
    let!(:transaction_types) { TransactionType.create(category: "Test Category") }

    scenario 'successfully' do
        visit transaction_types_path

        # need to sign in before visiting any path and doing testing
        click_link 'Sign in with your TAMU Google Account'

        expect(TransactionType.count).to eq(1)
        visit transaction_types_path
        expect(page).to have_content("Test Category")

        click_on 'Destroy'

        expect(page).to have_content('Transaction type was successfully destroyed.')
        expect(Member.count).to eq(0)
    end
end



RSpec.describe 'Edit member', type: :feature do
    before do
        Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
        Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
    end
    
    # Create mock Transaction Type object
    let!(:transaction_types) { TransactionType.create(category: "Test Category") }
    
    scenario 'successfully' do
        visit transaction_types_path

        # need to sign in before visiting any path and doing testing
        click_link 'Sign in with your TAMU Google Account'

        expect(TransactionType.count).to eq(1)
        visit transaction_types_path
        expect(page).to have_content("Test Category")

        click_on 'Edit'

        # fill in attributes
        fill_in 'Category', with: 'New Category'
        click_on 'Update Transaction type'


        expect(page).to have_content('Transaction type was successfully updated.')
        expect(page).to have_content("New Category")
    end
end


RSpec.describe 'Show TransactionType', type: :feature do
    before do
        Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
        Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
    end

    # Create mock Transaction Type object
    let!(:transaction_types) { TransactionType.create(category: "Test Category") }
    
    scenario 'successfully' do
        visit transaction_types_path

        # need to sign in before visiting any path and doing testing
        click_link 'Sign in with your TAMU Google Account'

        expect(TransactionType.count).to eq(1)
        visit transaction_types_path
        expect(page).to have_content("Test Category")
        
        click_on 'Show'
        
        expect(page).to have_content("Test Category")
    end
end