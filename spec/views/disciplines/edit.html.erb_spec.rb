require 'rails_helper'

RSpec.describe "disciplines/edit", type: :view do
  before(:each) do
    @discipline = assign(:discipline, Discipline.create!(
      :name => "MyString",
      :owner => nil
    ))
  end

  it "renders the edit discipline form" do
    render

    assert_select "form[action=?][method=?]", discipline_path(@discipline), "post" do

      assert_select "input#discipline_name[name=?]", "discipline[name]"

      assert_select "input#discipline_owner_id[name=?]", "discipline[owner_id]"
    end
  end
end
