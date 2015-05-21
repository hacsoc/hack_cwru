Given(/^I am not signed in$/) do
  visit root_path
  page.has_content? 'Sign out' || sign_out
end

Given(/^I am signed in$/) do
  sign_in
end

When(/^I visit "(.*)"$/) do |path|
  visit path
end

When(/^I click the link "(.*)"$/) do |text|
  click_link text
end
