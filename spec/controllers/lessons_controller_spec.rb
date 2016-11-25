require 'rails_helper'

RSpec.describe LessonsController, type: :controller do
  let(:lesson) { FactoryGirl.create(:lesson)}


  # INDEX
  describe "GET #index" do

    it "returns http success" do
      get :index, :kindergarten_id => lesson.kindergarten_id
      expect(response).to have_http_status(:success)
    end

    # fail
    it 'sets the lessons instance variable' do
      get :index, :kindergarten_id => lesson.kindergarten_id
      expect(assigns(:lesson)).to eq([]) #nil
    end

    it 'renders the index template' do
      get :index, :kindergarten_id => lesson.kindergarten_id
      expect(response).to render_template(:index)
    end

    # fail
    it 'has lessons in the lessons instance variable' do
      3.times { |index| Lesson.create(subject: "#{index}logy", teacher: "Mrs_#{index}", bully: "Mark", bullied: "Markie") } #just creating 1!
      get :index, :kindergarten_id => lesson.kindergarten_id
      expect(assigns(:lessons).length).to eq(3)
      expect(assigns(:lessons).last.name).to eq('2logy')
    end

  end


  # NEW all pass
  describe "GET #new" do

    it "returns http success" do
      get :new, :kindergarten_id => lesson.kindergarten_id
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      get :new, :kindergarten_id => lesson.kindergarten_id
      expect(response).to render_template(:new)
    end

    it "sets the new instance variable" do
      get :new, :kindergarten_id => lesson.kindergarten_id
      expect(assigns(:lesson)).to_not eq(nil)
      expect(assigns(:lesson).id).to eq(nil)
    end

  end


  # CREATE
  describe "POST #create" do

    before(:all) do
      @lesson_params = { lesson: { subject: 'Math', teacher: 'Mrs_Antipathy', bully: 'Johnny', bullied: 'Charlie'} }
    end

    # fail #no route matches
    it "sets the lesson instance variable" do
      post :create, @lesson_params
      expect(assigns(:lesson)).to_not eq(nil)
      expect(assigns(:lesson).subject).to eq(@lesson_params[:lesson][:subject])
    end

    # fail #no route matches
    it "creates a new lesson" do
      expect(Lesson.count).to eq(0)
      post :create, @lesson_params
      expect(Lesson.count).to eq(1)
      expect(Lesson.first.name).to eq(@lesson_params[:lesson][:subject])
    end

    # fail #no route matches
    it "sets a flash message on success" do
      post :create, @lesson_params
      expect(flash[:success]).to eq('Lesson Created!')
    end

    it "sets a flash message on error" do
      post :create, { :kindergarten_id => lesson.kindergarten_id, id: lesson.id, lesson: { subject: nil, teacher: 'Mr_Test', bully: 'X', bullied: 'Y'}}
      expect(flash[:error]).to eq('Fix errors and try again')
    end

    it "renders new on fail" do
      post :create, { :kindergarten_id => lesson.kindergarten_id, id: lesson.id, lesson: { subject: nil, teacher: 'Mr_Test', bully: 'X', bullied: 'Y'}}
      expect(response).to render_template(:new)
    end
  end


  # EDIT all pass
  describe "GET #edit" do

    it "returns http success" do
      get :edit, :kindergarten_id => lesson.kindergarten_id, id: lesson.id
      expect(response).to have_http_status(:success)
    end

    it "renders edit template" do
      get :edit, :kindergarten_id => lesson.kindergarten_id, id: lesson.id
      expect(response). to render_template(:edit)
    end

    it "sets lesson instance variable" do
      get :edit, :kindergarten_id => lesson.kindergarten_id, id: lesson.id
      expect(assigns(:lesson).id).to eq(lesson.id)
    end

  end

  # UPDATE all pass
  describe 'PUT #update' do

    it "sets the lesson instance variable" do
      put :update, { :kindergarten_id => lesson.kindergarten_id, id: lesson.id, lesson: { subject: 'New lesson' }}
      expect(assigns(:lesson).id).to eq(lesson.id)
    end

    it "updates the lesson" do
      put :update, { :kindergarten_id => lesson.kindergarten_id, id: lesson.id, lesson: { subject: 'New lesson'}}
      expect(lesson.reload.subject).to eq('New lesson')
    end

    it "sets a flash message on success" do
      put :update, { :kindergarten_id => lesson.kindergarten_id, id: lesson.id, lesson: {subject: 'New lesson'}}
      expect(flash[:success]).to eq('Lesson Updated!')
    end

    it "redirect to show on success" do
      put :update, { :kindergarten_id => lesson.kindergarten_id, id: lesson.id, lesson: { subject: 'New lesson'}}
      expect(response).to redirect_to(kindergarten_lesson_path(lesson.id))
    end

    describe 'update failures' do

      it "renders edit on fail" do
        put :update, { :kindergarten_id => lesson.kindergarten_id, id: lesson.id, lesson: { subject: nil } }
        expect(response).to render_template(:edit)
      end

      it "sets a flash message on error" do
        put :update, { :kindergarten_id => lesson.kindergarten_id, id: lesson.id, lesson: { subject: nil } }
        expect(flash[:error]).to eq('Fix errors and try again')
      end

    end
  end

  # SHOW all pass
  describe "GET #show" do

    it "returns http success" do
      get :show, :kindergarten_id => lesson.kindergarten_id, id: lesson.id
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      get :show, :kindergarten_id => lesson.kindergarten_id, id: lesson.id
      expect(response).to render_template(:show)
    end

    it "set the lesson instance variable" do
      get :show, :kindergarten_id => lesson.kindergarten_id, id: lesson.id
      expect(assigns(:lesson).subject).to eq(lesson.subject)
    end

  end


  # DESTROY
  describe "DELETE #destroy" do

    it "sets the lesson instance variable" do
      delete :destroy, :kindergarten_id => lesson.kindergarten_id, id: lesson.id
      expect(assigns(:lesson)).to eq(lesson)
    end

    # fails
    it "destroys the lesson" do
      lesson
      expect(lesson.count).to eq(1) #undefined method `count'
      delete :destroy, :kindergarten_id => lesson.kindergarten_id, id: lesson.id
      expect(lesson.count).to eq(0)
    end

    it "sets the flash message" do
      delete :destroy, :kindergarten_id => lesson.kindergarten_id, id: lesson.id
      expect(flash[:success]).to eq('Lesson Successfully Deleted!')
    end

    it "redirect to index path after destroy" do
      delete :destroy, :kindergarten_id => lesson.kindergarten_id, id: lesson.id
      expect(response).to redirect_to(kindergarten_lesson_path)
    end
  end

end
