require 'rails_helper'

RSpec.describe IndexController, type: :controller do
  before(:each) { allow(controller).to receive(:set_locale) }

  shared_examples 'setting locale' do
    it 'should call set_locale' do
      expect(controller).to have_received(:set_locale)
    end
  end

  shared_examples 'successful response' do
    it 'returns HTTP success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    before(:each) { get :index }

    it_should_behave_like 'successful response'
    it_should_behave_like 'setting locale'
  end

  describe "GET #about" do
    before(:each) { get :about }

    it_should_behave_like 'successful response'
    it_should_behave_like 'setting locale'
  end

end
