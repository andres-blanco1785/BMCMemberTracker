require 'rails_helper'

RSpec.describe "transcation_types/edit", type: :view do
  before(:each) do
    @transcation_type = assign(:transcation_type, TranscationType.create!(
      transaction_id: 1,
      category: "MyString"
    ))
  end

  it "renders the edit transcation_type form" do
    render

    assert_select "form[action=?][method=?]", transcation_type_path(@transcation_type), "post" do

      assert_select "input[name=?]", "transcation_type[transaction_id]"

      assert_select "input[name=?]", "transcation_type[category]"
    end
  end
end
