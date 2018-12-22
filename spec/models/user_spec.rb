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

  describe '#notify_admins' do
    context "with admins" do
      let!(:admin1) { Fabricate(:admin) }
      let!(:admin2) { Fabricate(:admin) }

      it "sends an email to all admin users" do
        Fabricate(:user)
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end

      it "sends emails to all admin users" do
        Fabricate(:user)
        admin_emails = User.where(role: "admin").pluck(:email)
        sent_emails = ActionMailer::Base.deliveries.map(&:to).first

        expect(admin_emails).to eq(sent_emails)
      end
    end

    context "with no admin users" do
      it "does not send any emails" do
        Fabricate(:user)
        expect(ActionMailer::Base.deliveries.count).to eq(0)
      end
    end
  end
end
