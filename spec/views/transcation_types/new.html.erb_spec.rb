require 'rails_helper'

RSpec.describe "transcation_types/new", type: :view do
  before(:each) do
    assign(:transcation_type, TranscationType.new(
      transaction_id: 1,
      category: "MyString"
    ))
  end

  it "renders new transcation_type form" do
    render

    assert_select "form[action=?][method=?]", transcation_types_path, "post" do

      assert_select "input[name=?]", "transcation_type[transaction_id]"

      assert_select "input[name=?]", "transcation_type[category]"
    end
  end
end
