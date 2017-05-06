require 'rails_helper'

RSpec.describe "disciplines/new", type: :view do
  before(:each) do
    assign(:discipline, Discipline.new(
      :name => "MyString",
      :owner => nil
    ))
  end

  it "renders new discipline form" do
    render

    assert_select "form[action=?][method=?]", disciplines_path, "post" do

      assert_select "input#discipline_name[name=?]", "discipline[name]"

      assert_select "input#discipline_owner_id[name=?]", "discipline[owner_id]"
    end
  end
end
