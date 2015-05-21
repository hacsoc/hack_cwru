Given(/^A user exists with some password$/) do
  @user = FactoryGirl.build(:user)
  @password = @user.password
  expect(@password).to_not be nil
  expect(@user.save).to be true
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
  visit '/sign_in'

  within '.sign-in' do
    fill_in 'session_email', with: @user.email
    fill_in 'session_password', with: @password
  end

  click_button 'Sign in'
end

Then(/^I should exist as a user$/) do
  expect(User.count).to eq (@old_count + 1)
  @created_user = User.find_by(email: @new_user.email)
  expect(@created_user).to_not be nil
end

Then(/^I should be signed in$/) do
  expect_user_to_be_signed_in
end
