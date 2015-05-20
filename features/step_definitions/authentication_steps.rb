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

Then(/^I should exist as a user$/) do
  expect(User.count).to eq (@old_count + 1)
  @created_user = User.find_by(email: @new_user.email)
  expect(@created_user).to_not be nil
end

Then(/^I should be signed in$/) do
  expect_user_to_be_signed_in
end
