require 'rails_helper'

RSpec.describe DisciplinesController, type: :controller do
  include Devise::Test::ControllerHelpers

  context "#when current user is a teacher" do
    describe "#GET index" do
      it "should only pass the teached disciplines of the current user to the view" do
        t1 = create(:teacher)
        t2 = create(:teacher)
        d1 = create(:discipline, {owner: t1})
        d2 = create(:discipline, {owner: t2})
        sign_in t1
        get :index
        expect(assigns(:disciplines)).to eq([d1])
      end
    end
    describe "#POST a new discipline" do
      it "#should create a new discipline" do
        sign_in create(:teacher)
        expect {
          # setting the owner parameter to nil as it should be extracted from the current session
          post :create, params: {:discipline => attributes_for(:discipline, owner: nil)}
        }.to change {Discipline.count}.by(1)
      end
    end

    describe "#update" do
      it "#should update a discipline that belongs to the current user" do
        t = create(:teacher)
        d = create(:discipline, {name: "oldname"})
        sign_in t
        put :update, params: {:id => d.id, :discipline => {:name => "newname"}}
        d.reload
        expect(d.name).to eq("newname")
      end
    end

    describe "#delete" do
      it "#should destroy a discipline that belongs to the current user" do
        t = create(:teacher)
        d = create(:discipline, {owner: t})
        sign_in t
        expect {
          delete :destroy, params: {:id => d.id}
        }.to change{t.teached_disciplines.size}.by(-1)
      end
    end
  end
end