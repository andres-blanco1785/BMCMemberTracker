require 'rails_helper'

RSpec.describe "transaction_types/edit", type: :view do
  before(:each) do
    @transaction_type = assign(:transaction_type, TransactionType.create!(
      transaction_id: 1,
      category: "MyString"
    ))
  end

  it "renders the edit transaction_type form" do
    render

    assert_select "form[action=?][method=?]", transaction_type_path(@transaction_type), "post" do

      assert_select "input[name=?]", "transaction_type[transaction_id]"

      assert_select "input[name=?]", "transaction_type[category]"
    end
  end
end
