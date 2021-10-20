require 'rails_helper'

RSpec.describe "transaction_types/index", type: :view do
  before(:each) do
    assign(:transaction_types, [
      TransactionType.create!(
        transaction_id: 2,
        category: "Category"
      ),
      TransactionType.create!(
        transaction_id: 2,
        category: "Category"
      )
    ])
  end

  it "renders a list of transaction_types" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "Category".to_s, count: 2
  end
end
