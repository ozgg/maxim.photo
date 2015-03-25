require 'rails_helper'

RSpec.describe SessionsController, type: :controller, wip: true do
  let(:user) { create :user }
  before(:each) { allow(controller).to receive(:set_locale) }

  shared_examples 'setting locale' do
    it 'should call set_locale' do
      expect(controller).to have_received(:set_locale)
    end
  end

  shared_examples 'redirecting authorized user' do
    it 'should call redirect_authorized_user' do
      expect(response).to redirect_to(root_path)
    end
  end

  shared_examples 'successful response' do
    it 'returns HTTP success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET new' do
    context 'when user is not logged in' do
      before :each do
        session[:user_id] = nil
        get :new
      end

      it_should_behave_like 'setting locale'
      it_should_behave_like 'successful response'
    end

    context 'when user is logged in' do
      before :each do
        session[:user_id] = user.id
        get :new
      end

      it_should_behave_like 'redirecting authorized user'
    end
  end

  describe 'POST create' do
    pending
  end

  describe 'DELETE destroy' do
    pending
  end

  describe '#redirect_authorized_user' do
    context 'when user is logged in' do
      before(:each) { session[:user_id] = user.id }

      it 'redirects to root path' do
        expect(controller).to receive(:redirect_to).with(root_path)
        controller.send(:redirect_authorized_user)
      end
    end
  end
end
