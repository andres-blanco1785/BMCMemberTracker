require 'rails_helper'

RSpec.describe "withdrawals/show", type: :view do
  before(:each) do
    @withdrawal = assign(:withdrawal, Withdrawal.create!(
      withdraw_id: 2,
      officer_uin: 3,
      transaction_id: 4,
      amount: 5.5,
      title: "Title",
      description: "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5.5/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Description/)
  end
end
