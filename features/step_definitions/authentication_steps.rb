Given(/^A user exists with some password$/) do
  @user = FactoryGirl.build(:user)
  @password = @user.password
  expect(@password).to_not be nil
  expect(@user.save).to be true
end

Given(/^I have forgotten my password$/) do
  # Nothing to do here. Just makes the scenario read better.
end

When(/^I fill out the sign up form$/) do
  @old_count = User.count

  password = Forgery::Basic.password
  @new_user = FactoryGirl.build(:user, password: password)

  within('#sign_up') do
    fill_in 'user_name', with: @new_user.name
    fill_in 'user_email', with: @new_user.email
    fill_in 'user_institution', with: @new_user.institution
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password
  end

  click_button "Sign up"
end

When(/^I sign in$/) do
  sign_in_with(@user.email, @password)
end

When(/^I give an? ((?:in)?valid) email to password recovery$/) do |status|
  @email =
    if status == 'valid'
      User.first.try(:email) || FactoryGirl.create(:user).email
    else
      FactoryGirl.build(:user).email
    end

  within '.password-reset' do
    fill_in 'password_email', with: @email
  end

  click_button 'Reset password'
end

Then(/^I should exist as a user$/) do
  expect(User.count).to eq (@old_count + 1)
  @created_user = User.find_by(email: @new_user.email)
  expect(@created_user).to_not be nil
end

Then(/^I should be signed in$/) do
  expect_user_to_be_signed_in
end

Then(/^I should be signed out$/) do
  expect_user_to_be_signed_out
end

Then(/^I should receive a welcome email$/) do
  expect(ActionMailer::Base.deliveries.count).to eq 1
  mail = ActionMailer::Base.deliveries.first
  expect(mail.to).to eq [@new_user.email]
  expect(mail.subject).to eq 'Welcome to HackCWRU!'
end

Then(/^A password recovery email should be sent to that email$/) do
  expect(ActionMailer::Base.deliveries.count).to be 1
  mail = ActionMailer::Base.deliveries.first
  expect(mail.to).to eq [@email]
  expect(mail.subject).to eq 'Change your password'
end

Then(/^No password recovery email should be sent$/) do
  expect(ActionMailer::Base.deliveries.count).to be 0
end
