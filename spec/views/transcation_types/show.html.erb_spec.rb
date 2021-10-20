require 'rails_helper'

RSpec.describe "transcation_types/show", type: :view do
  before(:each) do
    @transcation_type = assign(:transcation_type, TranscationType.create!(
      transaction_id: 2,
      category: "Category"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Category/)
  end
end
