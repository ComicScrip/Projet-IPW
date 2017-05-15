require 'rails_helper'

RSpec.describe Exam, type: :model do
  context "#validation" do
    context "#with invalid attributes" do
      it "#should not save an exam without a name" do
        expect(build(:exam, {title: nil}).save).to be false
      end

      it "#should not save an exam without a discipline" do
        expect(build(:exam, {discipline: nil}).save).to be false
      end
    end

    context "#with valid attributes" do
      it "#should save an exam" do
        expect(build(:exam).save).to be true
      end
    end
  end

  context "#custom data fetching methods" do
    describe "#belonging_to_teacher(t)" do
      before(:each) do
        @t1 = create(:teacher)
        @t2 = create(:teacher)
        @d1 = create(:discipline, {beginsOn: '2017-03-1', endsOn: '2017-12-31', owner: @t1})
        @d2 = create(:discipline, {beginsOn: '2017-04-1', endsOn: '2017-12-31', owner: @t1})
        @d3 = create(:discipline, {owner: @t2})
        @e1 = create(:exam, {discipline: @d1})
        @e2 = create(:exam, {discipline: @d2})
        @e3 = create(:exam, {discipline: @d3})
        @resulting_collection = Exam.belonging_to_teacher(@t1)
      end

      it "should return the collection of exams whose discipline belongs to a teacher" do
        expect(@resulting_collection).to match_array([@e1, @e2])
      end

      it "should return the collection ordered by begin date of discipline (the most recent first)" do
        expect(@resulting_collection).to eq([@e2, @e1])
      end
    end
  end
end
