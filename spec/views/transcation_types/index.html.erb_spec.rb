require 'rails_helper'

RSpec.describe "transcation_types/index", type: :view do
  before(:each) do
    assign(:transcation_types, [
      TranscationType.create!(
        intger: "Intger",
        transcation_id: "Transcation",
        string: ""
      ),
      TranscationType.create!(
        intger: "Intger",
        transcation_id: "Transcation",
        string: ""
      )
    ])
  end

  it "renders a list of transcation_types" do
    render
    assert_select "tr>td", text: "Intger".to_s, count: 2
    assert_select "tr>td", text: "Transcation".to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
  end
end
