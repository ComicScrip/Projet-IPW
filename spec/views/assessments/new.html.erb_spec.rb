require 'rails_helper'

RSpec.describe "assessments/new", type: :view do
  before(:each) do
    assign(:assessment, Assessment.new(
      :grade => 1.5,
      :user => nil
    ))
  end

  it "renders new assessment form" do
    render

    assert_select "form[action=?][method=?]", assessments_path, "post" do

      assert_select "input#assessment_grade[name=?]", "assessment[grade]"

      assert_select "input#assessment_user_id[name=?]", "assessment[user_id]"
    end
  end
end
