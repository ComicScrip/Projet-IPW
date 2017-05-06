require 'rails_helper'

RSpec.describe "assessments/show", type: :view do
  before(:each) do
    @assessment = assign(:assessment, Assessment.create!(
      :grade => 2.5,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(//)
  end
end
