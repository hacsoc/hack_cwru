Given(/^I am not signed in$/) do
  visit root_path
  page.has_content? 'Sign out' || sign_out
end

Given(/^I am signed in$/) do
  sign_in
end

Given(/^I am staff$/) do
  expect(@user.update({staff: true})).to be true
end

Given(/^I am not staff$/) do
  expect(@user.update({staff: false})).to be true
end

When(/^I visit "(.*)"$/) do |path|
  visit path
end

When(/^I click the link "(.*)"$/) do |text|
  click_link text
end

Then(/^I should see "(.*)"$/) do |content|
  expect(page).to have_content content
end
