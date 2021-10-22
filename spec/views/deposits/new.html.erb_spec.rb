require 'rails_helper'

RSpec.describe "deposits/new", type: :view do
  before(:each) do
    assign(:deposit, Deposit.new(
      deposit_id: 1,
      officer_uin: 1,
      transcation_id: 1,
      amount: 1
    ))
  end

  it "renders new deposit form" do
    render

    assert_select "form[action=?][method=?]", deposits_path, "post" do

      assert_select "input[name=?]", "deposit[deposit_id]"

      assert_select "input[name=?]", "deposit[officer_uin]"

      assert_select "input[name=?]", "deposit[transcation_id]"

      assert_select "input[name=?]", "deposit[amount]"
    end
  end
end
