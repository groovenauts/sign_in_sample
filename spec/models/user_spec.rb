require 'rails_helper'

RSpec.describe User, :type => :model do
  describe 'from_omniauth' do
    it 'create' do
      auth = OmniAuth::AuthHash.new
      auth.provider = 'my provider'
      auth.uid = 'my uid'
      auth.info = {email: 'email@example.com', name: 'my name'}

      new_user = User.from_omniauth(auth)

      expect(new_user.provider).to eq(auth.provider)
      expect(new_user.uid).to eq(auth.uid)
      expect(new_user.email).to eq(auth.info.email)
      expect(new_user.password).not_to be_nil
      expect(new_user.password.size).to eq(20)
      expect(new_user.role).to eq('admin')
      expect(new_user.name).to eq(auth.info.name)
    end

    it 'create (nothing email)' do
      auth = OmniAuth::AuthHash.new
      auth.provider = 'my provider'
      auth.uid = 'my uid'
      auth.info = {email: '', name: 'my name'}

      new_user = User.from_omniauth(auth)

      expect(new_user.email).not_to be_nil
    end

  end
end
