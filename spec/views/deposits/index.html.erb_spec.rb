require 'rails_helper'

RSpec.describe "deposits/index", type: :view do
  before(:each) do
    assign(:deposits, [
      Deposit.create!(
        deposit_id: 2,
        officer_uin: 3,
        transcation_id: 4,
        amount: 5
      ),
      Deposit.create!(
        deposit_id: 2,
        officer_uin: 3,
        transcation_id: 4,
        amount: 5
      )
    ])
  end

  it "renders a list of deposits" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: 4.to_s, count: 2
    assert_select "tr>td", text: 5.to_s, count: 2
  end
end
