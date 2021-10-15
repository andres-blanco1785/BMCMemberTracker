require 'rails_helper'

RSpec.describe "transcation_types/show", type: :view do
  before(:each) do
    @transcation_type = assign(:transcation_type, TranscationType.create!(
      intger: "Intger",
      transcation_id: "Transcation",
      string: ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Intger/)
    expect(rendered).to match(/Transcation/)
    expect(rendered).to match(//)
  end
end
