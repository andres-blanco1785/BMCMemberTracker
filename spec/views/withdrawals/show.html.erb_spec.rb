require 'rails_helper'

RSpec.describe "withdrawals/show", type: :view do
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

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
