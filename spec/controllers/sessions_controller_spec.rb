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
        allow(controller).to receive(:current_user).and_return(nil)
        get :new
      end

      it_should_behave_like 'setting locale'
      it_should_behave_like 'successful response'
    end

    context 'when user is logged in' do
      before :each do
        allow(controller).to receive(:current_user).and_return(user)
        get :new
      end

      it_should_behave_like 'redirecting authorized user'
    end
  end

  describe 'POST create' do
    context 'when user is logged in' do
      before(:each) { allow(controller).to receive(:current_user).and_return(user) }

      it 'redirects to root path' do
        post :create, login: user.login, password: 'secret'
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is not logged in' do
      before(:each) { allow(controller).to receive(:current_user).and_return(nil) }

      context 'when credentials are valid' do
        before(:each) { post :create, login: user.login, password: 'secret' }

        it 'sets user_id in session' do
          expect(session[:user_id]).to eq(user.id)
        end

        it 'redirects to root path' do
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when credentials are invalid' do
        before(:each) { post :create, login: user.login, password: 'invalid' }

        it 'renders template new' do
          expect(response).to render_template(:new)
        end
      end
    end
  end

  describe 'DELETE destroy' do
    it 'sets user_id in session to nil'
    it 'redirects to root path'
  end

  describe '#redirect_authorized_user' do
    it 'redirects to root path' do
      expect(controller).to receive(:redirect_to).with(root_path)
      controller.send(:redirect_authorized_user)
    end
  end
end
