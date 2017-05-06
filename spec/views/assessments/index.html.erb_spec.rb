require 'rails_helper'

RSpec.describe "assessments/index", type: :view do
  before(:each) do
    assign(:assessments, [
      Assessment.create!(
        :grade => 2.5,
        :user => nil
      ),
      Assessment.create!(
        :grade => 2.5,
        :user => nil
      )
    ])
  end

  it "renders a list of assessments" do
    render
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
