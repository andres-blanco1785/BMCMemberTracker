require 'rails_helper'

RSpec.describe "withdrawals/index", type: :view do
  before(:each) do
    assign(:withdrawals, [
      Withdrawal.create!(
        integer: "",
        integer: "",
        integer: "",
        float: "",
        string: "",
        string: ""
      ),
      Withdrawal.create!(
        integer: "",
        integer: "",
        integer: "",
        float: "",
        string: "",
        string: ""
      )
    ])
  end

  it "renders a list of withdrawals" do
    render
    assert_select "tr>td", text: "".to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
  end
end
