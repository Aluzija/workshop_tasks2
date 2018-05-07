require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe 'GET tasks/new' do
    it 'exposes form to create new task' do
      get :new
      expect(response).to be_success
      assert_template 'tasks/new'
    end
  end

  describe 'POST tasks' do
    context "for no task attributes given" do
      it 'does not create new task and renders new template' do
        expect {
          post :create, params: { task: { foo: 'bar' } }
        }.not_to change(Task, :count)
        expect(response).to render_template(:new)
        expect(response).not_to redirect_to tasks_url
      end
    end

    context "for task attributes given" do
      it 'creates new task and redirects to index view' do
        expect {
          post :create, params: { task: { title: 'foo', description: 'bar' } }
        }.to change(Task, :count).by 1
        expect(response).to redirect_to tasks_url
        expect(response).not_to render_template(:new)
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe 'GET tasks' do
    it 'lists all the tasks' do
      get :index
      expect(response).to be_success
      assert_template 'tasks/index'
    end
  end
end
