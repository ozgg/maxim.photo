require 'rails_helper'

RSpec.describe AlbumsController, type: :controller do
  let(:user) { create :user }
  let!(:album) { create :album }
  let!(:hidden_album) { create :hidden_album }

  before :each do
    allow(controller).to receive(:allow_authorized_only)
  end

  shared_examples 'authorization checker' do
    it 'allows authorized users only' do
      expect(controller).to have_received(:allow_authorized_only)
    end
  end

  shared_examples 'album setter' do
    it 'assigns instance of Album in @album' do
      expect(assigns[:album]).to be_instance_of(Album)
    end
  end

  describe 'GET index' do
    context 'when user is not logged in' do
      before :each do
        session[:user_id] = nil
        get :index
      end

      it 'does not include hidden albums in @albums' do
        expect(assigns[:albums]).not_to include(hidden_album)
      end
    end

    context 'when user is logged in' do
      before :each do
        session[:user_id] = user.id
        get :index
      end

      it 'includes hidden albums in @albums' do
        expect(assigns[:albums]).to include(hidden_album)
      end
    end

    context 'when session does not matter' do
      before(:each) { get :index }

      it 'includes visible albums in @albums' do
        expect(assigns[:albums]).to include(album)
      end
    end
  end

  describe 'GET new' do
    before :each do
      session[:user_id] = user.id
      get :new
    end

    it_should_behave_like 'album setter'
    it_should_behave_like 'authorization checker'
  end

  describe 'POST create' do
    let(:action) { -> { post :create, album: attributes_for(:album) } }

    before :each do
      session[:user_id] = user.id
    end

    it 'checks user authorization' do
      action.call
      expect(controller).to have_received(:allow_authorized_only)
    end

    it 'assigns new instance of Album to @album' do
      action.call
      expect(assigns[:album]).to be_instance_of(Album)
    end

    it 'creates new record in albums table' do
      expect(action).to change(Album, :count).by(1)
    end

    it 'redirects to created album' do
      action.call
      expect(response).to redirect_to(Album.last)
    end
  end

  describe 'GET show' do
    before(:each) { get :show, id: album }

    it_should_behave_like 'album setter'
  end

  describe 'GET edit' do
    before :each do
      session[:user_id] = user.id
      get :edit, id: album.id
    end

    it_should_behave_like 'album setter'
    it_should_behave_like 'authorization checker'
  end

  describe 'PATCH update' do
    before(:each) { patch :update, id: album.id, album: { priority: 5 } }

    it 'assigns album to @album' do
      expect(assigns[:album]).to eq(album)
    end

    it 'checks user authorization' do
      expect(controller).to have_received(:allow_authorized_only)
    end

    it 'updates album' do
      album.reload
      expect(album.priority).to eq(5)
    end

    it 'redirects to album path' do
      expect(response).to redirect_to(album)
    end
  end

  describe 'DELETE destroy' do
    let(:action) { -> { delete :destroy, id: album.id } }

    it 'assigns album to @album' do
      action.call
      expect(assigns[:album]).to eq(album)
    end

    it 'checks user authorization' do
      action.call
      expect(controller).to have_received(:allow_authorized_only)
    end

    it 'deletes album' do
      expect(action).to change(Album, :count).by(-1)
    end

    it 'redirects to albums path' do
      action.call
      expect(response).to redirect_to(albums_path)
    end
  end
end
