require 'rails_helper'

RSpec.describe "deposits/index", type: :view do
  before(:each) do
    assign(:deposits, [
      Deposit.create!(
        integer: "",
        integer: "",
        integer: "",
        float: ""
      ),
      Deposit.create!(
        integer: "",
        integer: "",
        integer: "",
        float: ""
      )
    ])
  end

  it "renders a list of deposits" do
    render
    assert_select "tr>td", text: "".to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
  end
end
