require 'rails_helper'

describe User do
  describe '#expired_token?' do
    let(:user) { Fabricate(:user) }

    it "returns true when the token id 5 minutes old" do
      user.generate_token!
      user.update_column(:token_expiration, Time.now - 1.minute)

      expect(user.expired_token?).to be true
    end

    it "returns false when the token is less than 5 minutes old" do
      user.generate_token!
      expect(user.expired_token?).to be false
    end
  end

  describe '#clear_token' do
    let(:user) { Fabricate(:user) }

    before do
      user.generate_token!
      user.clear_token
    end

    it "sets the user's token to nil" do
      expect(user.token).to be_nil
    end

    it "sets the token expiration to nil" do
      expect(user.token_expiration).to be_nil
    end
  end
end
