require 'rails_helper'

RSpec.describe ExamsController, type: :controller do
  include Devise::Test::ControllerHelpers

  context "#when current user is a teacher" do
    describe "#POST a new exam" do
      it "#should create a new exam" do
        t = create(:teacher)
        d = create(:discipline, {owner: t})
        sign_in t
        expect {
          post :create, params: {:exam => attributes_for(:exam).merge({:discipline_id => d.id})}
        }.to change {Exam.count}.by(1)
      end
    end

    describe "#update" do
      it "#should update an exam" do
        t = create(:teacher)
        d = create(:discipline, {owner: t})
        e = create(:exam, {title: "oldtitle", discipline: d})
        sign_in t
        put :update, params: {:id => e.id, :exam => {:title => "newtitle"}}
        e.reload
        expect(e.title).to eq("newtitle")
      end
    end

    describe "#delete" do
      it "#should destroy an exam" do
        t = create(:teacher)
        d = create(:discipline, {owner: t})
        e = create(:exam, {discipline: d})
        sign_in t
        expect {
          delete :destroy, params: {:id => e.id}
        }.to change{d.exams.size}.by(-1)
      end
    end
  end
end