require 'rails_helper'

RSpec.describe "transaction_types/new", type: :view do
  before(:each) do
    assign(:transaction_type, TransactionType.new(
      transaction_id: 1,
      category: "MyString"
    ))
  end

  it "renders new transaction_type form" do
    render

    assert_select "form[action=?][method=?]", transaction_types_path, "post" do

      assert_select "input[name=?]", "transaction_type[transaction_id]"

      assert_select "input[name=?]", "transaction_type[category]"
    end
  end
end
