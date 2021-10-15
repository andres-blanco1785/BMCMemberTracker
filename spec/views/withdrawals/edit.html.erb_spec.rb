require 'rails_helper'

RSpec.describe "withdrawals/edit", type: :view do
  before(:each) do
    @withdrawal = assign(:withdrawal, Withdrawal.create!(
      integer: "",
      integer: "",
      integer: "",
      float: "",
      string: "",
      string: ""
    ))
  end

  it "renders the edit withdrawal form" do
    render

    assert_select "form[action=?][method=?]", withdrawal_path(@withdrawal), "post" do

      assert_select "input[name=?]", "withdrawal[integer]"

      assert_select "input[name=?]", "withdrawal[integer]"

      assert_select "input[name=?]", "withdrawal[integer]"

      assert_select "input[name=?]", "withdrawal[float]"

      assert_select "input[name=?]", "withdrawal[string]"

      assert_select "input[name=?]", "withdrawal[string]"
    end
  end
end
