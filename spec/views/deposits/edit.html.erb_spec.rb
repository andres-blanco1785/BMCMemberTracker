require 'rails_helper'

RSpec.describe "deposits/edit", type: :view do
  before(:each) do
    @deposit = assign(:deposit, Deposit.create!(
      integer: "",
      integer: "",
      integer: "",
      float: ""
    ))
  end

  it "renders the edit deposit form" do
    render

    assert_select "form[action=?][method=?]", deposit_path(@deposit), "post" do

      assert_select "input[name=?]", "deposit[integer]"

      assert_select "input[name=?]", "deposit[integer]"

      assert_select "input[name=?]", "deposit[integer]"

      assert_select "input[name=?]", "deposit[float]"
    end
  end
end
