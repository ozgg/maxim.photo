require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it 'fails for blank login' do
      user = build :user, login: nil
      expect(user).not_to be_valid
    end

    it 'falis for blank password' do
      user = build :user, password: '', password_confirmation: ''
      expect(user).not_to be_valid
    end

    it 'fails for mismatching password and confirmation' do
      user = build :user, password: 'secret', password_confirmation: 'wrong'
      expect(user).not_to be_valid
    end

    it 'fails for non-unique login' do
      existing_user = create :user
      user = build :user, login: existing_user.login
      expect(user).not_to be_valid
    end

    it 'passes for unique login and filled password' do
      user = build :user
      expect(user).to be_valid
    end
  end
end
