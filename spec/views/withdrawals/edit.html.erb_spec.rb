require 'rails_helper'

RSpec.describe "withdrawals/edit", type: :view do
  before(:each) do
    @withdrawal = assign(:withdrawal, Withdrawal.create!(
      withdraw_id: 1,
      officer_uin: 1,
      transaction_id: 1,
      amount: 1.5,
      title: "MyString",
      description: "MyString"
    ))
  end

  it "renders the edit withdrawal form" do
    render

    assert_select "form[action=?][method=?]", withdrawal_path(@withdrawal), "post" do

      assert_select "input[name=?]", "withdrawal[withdraw_id]"

      assert_select "input[name=?]", "withdrawal[officer_uin]"

      assert_select "input[name=?]", "withdrawal[transaction_id]"

      assert_select "input[name=?]", "withdrawal[amount]"

      assert_select "input[name=?]", "withdrawal[title]"

      assert_select "input[name=?]", "withdrawal[description]"
    end
  end
end
