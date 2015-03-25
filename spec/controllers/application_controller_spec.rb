require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#current_user' do
    context 'when user is logged in' do
      let!(:user) { create :user }
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
end
