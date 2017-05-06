require 'rails_helper'

RSpec.describe "assessments/edit", type: :view do
  before(:each) do
    @assessment = assign(:assessment, Assessment.create!(
      :grade => 1.5,
      :user => nil
    ))
  end

  it "renders the edit assessment form" do
    render

    assert_select "form[action=?][method=?]", assessment_path(@assessment), "post" do

      assert_select "input#assessment_grade[name=?]", "assessment[grade]"

      assert_select "input#assessment_user_id[name=?]", "assessment[user_id]"
    end
  end
end
