require 'rails_helper'

RSpec.describe "exams/index", type: :view do
  before(:each) do
    assign(:exams, [
      Exam.create!(
        :title => "Title"
      ),
      Exam.create!(
        :title => "Title"
      )
    ])
  end

  it "renders a list of exams" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
