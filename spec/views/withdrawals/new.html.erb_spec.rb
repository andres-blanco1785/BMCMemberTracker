require 'rails_helper'

RSpec.describe "withdrawals/new", type: :view do
  before(:each) do
    assign(:withdrawal, Withdrawal.new(
      integer: "",
      integer: "",
      integer: "",
      float: "",
      string: "",
      string: ""
    ))
  end

  it "renders new withdrawal form" do
    render

    assert_select "form[action=?][method=?]", withdrawals_path, "post" do

      assert_select "input[name=?]", "withdrawal[integer]"

      assert_select "input[name=?]", "withdrawal[integer]"

      assert_select "input[name=?]", "withdrawal[integer]"

      assert_select "input[name=?]", "withdrawal[float]"

      assert_select "input[name=?]", "withdrawal[string]"

      assert_select "input[name=?]", "withdrawal[string]"
    end
  end
end
