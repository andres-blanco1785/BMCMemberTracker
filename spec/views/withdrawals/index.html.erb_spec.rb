require 'rails_helper'

RSpec.describe "withdrawals/index", type: :view do
  before(:each) do
    assign(:withdrawals, [
      Withdrawal.create!(
        withdraw_id: 2,
        officer_uin: 3,
        transaction_id: 4,
        amount: 5.5,
        title: "Title",
        description: "Description"
      ),
      Withdrawal.create!(
        withdraw_id: 2,
        officer_uin: 3,
        transaction_id: 4,
        amount: 5.5,
        title: "Title",
        description: "Description"
      )
    ])
  end

  it "renders a list of withdrawals" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: 4.to_s, count: 2
    assert_select "tr>td", text: 5.5.to_s, count: 2
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "Description".to_s, count: 2
  end
end
