require 'rails_helper'

RSpec.describe SutdentsController, type: :controller do
  let(:sutdent) { FactoryGirl.create(:sutdent)}

  # INDEX
  describe "GET #index" do

    it "returns http success" do
      get :index, :lesson_id => sutdent.lesson_id
      expect(response).to have_http_status(:success)
    end

    # fail
    it 'sets the sutdents instance variable' do
      get :index, { lesson_id: sutdent.lesson_id }
      expect(assigns(:sutdent)).to eq([]) #nil
    end

    it 'renders the index template' do
      get :index, :lesson_id => sutdent.lesson_id
      expect(response).to render_template(:index)
    end

    # fail
    it 'has sutdents in the sutdents instance variable' do
      3.times { |index| Sutdent.create(name: "George the #{index}st", behaves: true) } #just creating 1!
      get :index, :lesson_id => sutdent.lesson_id
      expect(assigns(:sutdents).length).to eq(3)
      expect(assigns(:sutdents).last.name).to eq('George the 2st')
    end

  end

  # NEW all pass
  describe "GET #new" do

    it "returns http success" do
      get :new, :lesson_id => sutdent.lesson_id
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      get :new, :lesson_id => sutdent.lesson_id
      expect(response).to render_template(:new)
    end

    it "sets the new instance variable" do
      get :new, :lesson_id => sutdent.lesson_id
      expect(assigns(:sutdent)).to_not eq(nil)
      expect(assigns(:sutdent).id).to eq(nil)
    end

  end


  # CREATE all fail
  describe "POST #create" do

    before(:each) do
      @lesson = FactoryGirl.create(:lesson)
      @sutdent_params = { lesson_id: @lesson.id, sutdent: { name: 'Charlie', behaves: false} }
    end

    # fail #no route matches
    it "sets the sutdent instance variable" do
      post :create, @sutdent_params
      expect(assigns(:sutdent)).to_not eq(nil)
      expect(assigns(:sutdent).name).to eq(@sutdent_params[:sutdent][:name])
    end

    # fail #no route matches
    it "creates a new sutdent" do
      expect(Sutdent.count).to eq(0)
      post :create, @sutdent_params
      expect(Sutdent.count).to eq(1)
      expect(Sutdent.first.name).to eq(@sutdent_params[:sutdent][:name])
    end

    # fail #no route matches
    it "sets a flash message on success" do
      post :create, @sutdent_params
      expect(flash[:success]).to eq('Student created!')
    end

    # fail undefined method `new_url'
    it "sets a flash message on error" do
      post :create, { :lesson_id => sutdent.lesson_id, id: sutdent.id, sutdent: { name: nil }}
      expect(flash[:error]).to eq('Failed to create!')
    end

    # fail undefined method `new_url'
    it "renders new on fail" do
      post :create, { :lesson_id => sutdent.lesson_id, id: sutdent.id, sutdent: { name: nil }}
      expect(response).to render_template(:new)
    end
  end

  # EDIT all pass
  describe "GET #edit" do

    it "returns http success" do
      get :edit, :lesson_id => sutdent.lesson_id, id: sutdent.id
      expect(response).to have_http_status(:success)
    end

    it "renders edit template" do
      get :edit, :lesson_id => sutdent.lesson_id, id: sutdent.id
      expect(response). to render_template(:edit)
    end

    it "sets sutdent instance variable" do
      get :edit, :lesson_id => sutdent.lesson_id, id: sutdent.id
      expect(assigns(:sutdent).id).to eq(sutdent.id)
    end

  end

  # UPDATE all pass
  describe 'PUT #update' do

    it "sets the sutdent instance variable" do
      put :update, { :lesson_id => sutdent.lesson_id, id: sutdent.id, sutdent: { name: 'New sutdent' }}
      expect(assigns(:sutdent).id).to eq(sutdent.id)
    end

    it "updates the sutdent" do
      put :update, { :lesson_id => sutdent.lesson_id, id: sutdent.id, sutdent: { name: 'New sutdent'}}
      expect(sutdent.reload.name).to eq('New sutdent')
    end

    it "sets a flash message on success" do
      put :update, { :lesson_id => sutdent.lesson_id, id: sutdent.id, sutdent: {name: 'New sutdent'}}
      expect(flash[:success]).to eq('Sutdent Updated!')
    end

    it "redirect to show on success" do
      put :update, { :lesson_id => sutdent.lesson_id, id: sutdent.id, sutdent: { name: 'New sutdent'}}
      expect(response).to redirect_to(lesson_sutdent_path)
    end

    describe 'update failures' do

      it "renders edit on fail" do
        put :update, { :lesson_id => sutdent.lesson_id, id: sutdent.id, sutdent: { name: nil } }
        expect(response).to render_template(:edit)
      end

      it "sets a flash message on error" do
        put :update, { :lesson_id => sutdent.lesson_id, id: sutdent.id, sutdent: { name: nil } }
        expect(flash[:error]).to eq('Failed to update!')
      end

    end
  end

  # SHOW all pass
  describe "GET #show" do

    it "returns http success" do
      get :show, :lesson_id => sutdent.lesson_id, id: sutdent.id
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      get :show, :lesson_id => sutdent.lesson_id, id: sutdent.id
      expect(response).to render_template(:show)
    end

    it "set the sutdent instance variable" do
      get :show, :lesson_id => sutdent.lesson_id, id: sutdent.id
      expect(assigns(:sutdent).name).to eq(sutdent.name)
    end

  end

  # DESTROY all pass
  describe "DELETE #destroy" do

    it "sets the sutdent instance variable" do
      delete :destroy, :lesson_id => sutdent.lesson_id, id: sutdent.id
      expect(assigns(:sutdent)).to eq(sutdent)
    end

    it "destroys the sutdent" do
      sutdent
      expect(Sutdent.count).to eq(1)
      delete :destroy, :lesson_id => sutdent.lesson_id, id: sutdent.id
      expect(Sutdent.count).to eq(0)
    end

    it "sets the flash message" do
      delete :destroy, :lesson_id => sutdent.lesson_id, id: sutdent.id
      expect(flash[:success]).to eq('Sutdent Successfully Deleted!')
    end

    it "redirect to index path after destroy" do
      delete :destroy, :lesson_id => sutdent.lesson_id, id: sutdent.id
      expect(response).to redirect_to(lesson_sutdent_path)
    end
  end

end
