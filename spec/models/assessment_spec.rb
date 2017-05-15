require 'rails_helper'

RSpec.describe Assessment, type: :model do
  context "#validation" do
    context "#with invalid attributes" do
      it "#should not save an assessement with an invalid grade" do
        expect(build(:assessment, {grade: 21}).save).to be false
        expect(build(:assessment, {grade: -1}).save).to be false
      end
    end

    context "#with valid attributes" do
      it "#should save an assessement" do
        expect(build(:assessment).save).to be true
      end
    end
  end
end
