require 'rails_helper'

RSpec.describe "transaction_types/show", type: :view do
  before(:each) do
    @transaction_type = assign(:transaction_type, TransactionType.create!(
      transaction_id: 2,
      category: "Category"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Category/)
  end
end
