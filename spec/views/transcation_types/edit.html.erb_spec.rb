require 'rails_helper'

RSpec.describe "transcation_types/edit", type: :view do
  before(:each) do
    @transcation_type = assign(:transcation_type, TranscationType.create!(
      intger: "MyString",
      transcation_id: "MyString",
      string: ""
    ))
  end

  it "renders the edit transcation_type form" do
    render

    assert_select "form[action=?][method=?]", transcation_type_path(@transcation_type), "post" do

      assert_select "input[name=?]", "transcation_type[intger]"

      assert_select "input[name=?]", "transcation_type[transcation_id]"

      assert_select "input[name=?]", "transcation_type[string]"
    end
  end
end
