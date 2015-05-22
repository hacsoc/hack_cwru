require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe '#welcome' do
    before do
      ActionMailer::Base.deliveries = []
      @user = FactoryGirl.build(:user)
      UserMailer.welcome(@user).deliver_now
    end

    it 'sends an email to the user' do
      expect(ActionMailer::Base.deliveries.count).to eq 1
      expect(ActionMailer::Base.deliveries.first.to).to eq [@user.email]
    end
  end
end
