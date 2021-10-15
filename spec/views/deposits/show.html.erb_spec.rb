require 'rails_helper'

RSpec.describe "deposits/show", type: :view do
  before(:each) do
    @deposit = assign(:deposit, Deposit.create!(
      integer: "",
      integer: "",
      integer: "",
      float: ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
