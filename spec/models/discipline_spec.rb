require 'rails_helper'

RSpec.describe Discipline, type: :model do
  context "#validation" do
    context "#with invalid attributes" do
      it "should not save a discipline without owner" do
        d = build(:discipline, {owner: nil})
        expect(d.save).to be false
      end

      it "should not save a discipline without a name" do
        d = build(:discipline, {name: nil})
        expect(d.save).to be false
      end

      it "should not save a discipline when owner is not a teacher" do
        d = build(:discipline, {owner: create(:user)})
        expect(d.save).to be false
      end

      it "should not save a discipline with missing dates" do
        d = build(:discipline, {beginsOn: nil})
        expect(d.save).to be false
        d = build(:discipline, {endsOn: nil})
        expect(d.save).to be false
      end

      it "should not save a discipline with begin date greater than end date" do
        d = build(:discipline, {beginsOn: Date.today + 1, endsOn: Date.today})
        expect(d.save).to be false
      end
    end

    context "#with valid attributes" do
      it "#should save a discipline when all attributes are valid" do
        d = build(:discipline)
        expect(d.save).to be true
      end
    end
  end
end
