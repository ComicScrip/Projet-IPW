require 'rails_helper'

RSpec.describe "disciplines/show", type: :view do
  before(:each) do
    @discipline = assign(:discipline, Discipline.create!(
      :name => "Name",
      :owner => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end
