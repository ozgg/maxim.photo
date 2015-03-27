require 'rails_helper'

RSpec.describe CategoriesController, type: :controller, wip: true do
  let(:user) { create :user }
  let!(:main_category) { create :category }
  let!(:visible_category) { create :visible_category }
  let!(:hidden_category) { create :hidden_category }

  before :each do
    allow(controller).to receive(:allow_authorized_only)
  end

  shared_examples 'authorization checker' do
    it 'allows authorized users only' do
      expect(controller).to have_received(:allow_authorized_only)
    end
  end

  shared_examples 'category setter' do
    it 'assigns instance of Category in @category' do
      expect(assigns[:category]).to be_instance_of(Category)
    end
  end

  describe 'GET index' do
    context 'when user is not logged in' do
      before :each do
        session[:user_id] = nil
        get :index
      end

      it 'does not include hidden categories in @categories' do
        expect(assigns[:categories]).not_to include(hidden_category)
      end
    end

    context 'when user is logged in' do
      before :each do
        session[:user_id] = user.id
        get :index
      end

      it 'includes hidden categories in @categories' do
        expect(assigns[:categories]).to include(hidden_category)
      end
    end

    context 'when session does not matter' do
      before(:each) { get :index }

      it 'includes visible categories in @categories' do
        expect(assigns[:categories]).to include(visible_category)
      end

      it 'includes main categories in @categories' do
        expect(assigns[:categories]).to include(main_category)
      end
    end
  end

  describe 'GET new' do
    before :each do
      session[:user_id] = user.id
      get :new
    end

    it_should_behave_like 'category setter'
    it_should_behave_like 'authorization checker'
  end

  describe 'POST create' do
    let(:action) { -> { post :create, category: attributes_for(:category, visibility: 'main') } }

    before :each do
      session[:user_id] = user.id
    end

    it 'checks user authorization' do
      action.call
      expect(controller).to have_received(:allow_authorized_only)
    end

    it 'assigns new instance of Category to @category' do
      action.call
      expect(assigns[:category]).to be_instance_of(Category)
    end

    it 'creates new record in categories table' do
      expect(action).to change(Category, :count).by(1)
    end

    it 'redirects to created category' do
      action.call
      expect(response).to redirect_to(Category.last)
    end
  end

  describe 'GET show' do
    before(:each) { get :show, id: main_category }

    it_should_behave_like 'category setter'
  end

  describe 'GET edit' do
    before :each do
      session[:user_id] = user.id
      get :edit, id: main_category.id
    end

    it_should_behave_like 'category setter'
    it_should_behave_like 'authorization checker'
  end

  describe 'PATCH update' do
    it 'assigns category to @category'
    it 'checks user authorization'
    it 'updates category'
    it 'redirects to category path'
  end

  describe 'DELETE destroy' do
    it 'assigns category to @category'
    it 'checks user authorization'
    it 'deletes category'
  end
end
