require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let(:user) { create :user }

  describe '#current_user' do
    context 'when user is logged in' do
      before(:each) { session[:user_id] = user.id }

      it 'returns current user' do
        expect(controller.current_user).to eq(user)
      end
    end

    context 'when user is not logged in' do
      before(:each) { session[:user_id] = nil }

      it 'returns nil' do
        expect(controller.current_user).to be_nil
      end
    end
  end

  describe '#allow_authorized_only' do
    context 'when user is logged in' do
      before(:each) { session[:user_id] = user.id }

      it 'does not redirect to login page' do
        expect(controller).not_to receive(:redirect_to)
        controller.send(:allow_authorized_only)
      end
    end

    context 'when user is not logged in' do
      before(:each) { session[:user_id] = nil }

      it 'redirects to login page' do
        expect(controller).to receive(:redirect_to).with(login_path)
        controller.send(:allow_authorized_only)
      end
    end
  end
end
