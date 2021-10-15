require 'rails_helper'

RSpec.describe "deposits/new", type: :view do
  before(:each) do
    assign(:deposit, Deposit.new(
      integer: "",
      integer: "",
      integer: "",
      float: ""
    ))
  end

  it "renders new deposit form" do
    render

    assert_select "form[action=?][method=?]", deposits_path, "post" do

      assert_select "input[name=?]", "deposit[integer]"

      assert_select "input[name=?]", "deposit[integer]"

      assert_select "input[name=?]", "deposit[integer]"

      assert_select "input[name=?]", "deposit[float]"
    end
  end
end
