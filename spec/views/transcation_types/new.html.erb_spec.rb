require 'rails_helper'

RSpec.describe "transcation_types/new", type: :view do
  before(:each) do
    assign(:transcation_type, TranscationType.new(
      intger: "MyString",
      transcation_id: "MyString",
      string: ""
    ))
  end

  it "renders new transcation_type form" do
    render

    assert_select "form[action=?][method=?]", transcation_types_path, "post" do

      assert_select "input[name=?]", "transcation_type[intger]"

      assert_select "input[name=?]", "transcation_type[transcation_id]"

      assert_select "input[name=?]", "transcation_type[string]"
    end
  end
end
