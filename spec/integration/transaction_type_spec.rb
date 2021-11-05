# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TransactionType Features', type: :feature do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end

  # Create mock Transaction Type object
  let!(:transaction_types) { TransactionType.create(category: 'Test Category') }

  it 'Create TransactionType w/empty category' do
    visit new_transaction_type_path

    # need to sign in before doing testing
    click_link 'Sign in with your TAMU Google Account'

    visit new_transaction_type_path
    expect(page.has_current_path?('/transaction_types/new')).to be(true)

    click_on 'Create Transaction type'

    expect(page.has_content?("Category can't be blank")).to be(true)

    # No transaction type record is created
    expect(Member.count).to eq(0)
  end

  it 'Create TransactionType w/valid inputs' do
    visit new_transaction_type_path

    # need to sign in before visiting any path and doing testing
    click_link 'Sign in with your TAMU Google Account'

    visit new_transaction_type_path
    fill_in 'Category', with: 'Test Category 2'
    click_on 'Create Transaction type'

    # A transaction type has been created
    expect(TransactionType.count).to eq(2)
    expect(page.has_content?('Transaction type was successfully created.')).to be(true)
    visit transaction_types_path
    expect(page.has_content?('Test Category')).to be(true)
  end

  it 'Create TransactionType w/duplicated category' do
    visit transaction_types_path

    # need to sign in before visiting any path and doing testing
    click_link 'Sign in with your TAMU Google Account'

    TransactionType.create(category: 'Test Category')

    # A member has been created
    expect(TransactionType.count).to eq(1)
    visit transaction_types_path
    expect(page.has_content?('Test Category')).to be(true)

    visit new_transaction_type_path
    fill_in 'Category', with: 'Test Category'
    click_on 'Create Transaction type'
    expect(page.has_content?('Category has already been taken')).to be(true)
  end

  it 'Destroy TransactionType successfully' do
    visit transaction_types_path

    # need to sign in before visiting any path and doing testing
    click_link 'Sign in with your TAMU Google Account'

    expect(TransactionType.count).to eq(1)
    visit transaction_types_path
    expect(page.has_content?('Test Category')).to be(true)

    click_on 'Destroy'

    expect(page.has_content?('Transaction type was successfully destroyed.')).to be(true)
    expect(Member.count).to eq(0)
  end

  it 'Edit TransactionType successfully' do
    visit transaction_types_path

    # need to sign in before visiting any path and doing testing
    click_link 'Sign in with your TAMU Google Account'

    expect(TransactionType.count).to eq(1)
    visit transaction_types_path
    expect(page.has_content?('Test Category')).to be(true)

    click_on 'Edit'

    # fill in attributes
    fill_in 'Category', with: 'New Category'
    click_on 'Update Transaction type'

    expect(page.has_content?('Transaction type was successfully updated.')).to be(true)
    expect(page.has_content?('New Category')).to be(true)
  end

  it 'Edit TransactionType unsuccessfully' do
    visit transaction_types_path

    # need to sign in before visiting any path and doing testing
    click_link 'Sign in with your TAMU Google Account'

    expect(TransactionType.count).to eq(1)
    visit transaction_types_path
    expect(page.has_content?('Test Category')).to be(true)

    click_on 'Edit'

    # fill in with blank attribute
    fill_in 'Category', with: ' '
    click_on 'Update Transaction type'

    expect(page.has_content?("Category can't be blank")).to be(true)
  end

  it 'Show TransactionType successfully' do
    visit transaction_types_path

    # need to sign in before visiting any path and doing testing
    click_link 'Sign in with your TAMU Google Account'

    expect(TransactionType.count).to eq(1)
    visit transaction_types_path
    expect(page.has_content?('Test Category')).to be(true)

    click_on 'Show'

    expect(page.has_content?('Test Category')).to be(true)
  end
end
