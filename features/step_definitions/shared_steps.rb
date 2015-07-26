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

When(/^I change the (.*)'s (.*)$/) do |obj_name, attr|
  new_attr = FactoryGirl.build(obj_name).send(attr)
  instance_variable_set("@#{attr}", new_attr)
  fill_in "#{obj_name}_#{attr}", with: new_attr
  find('.actions input[type="submit"]').click
end

Then(/^That (.*) should have the new (.*)$/) do |obj_name, attr|
  obj = instance_variable_get("@#{obj_name}").reload
  new_attr = instance_variable_get("@#{attr}")

  expect(obj.send attr).to eq new_attr
end

Then(/^I should see "(.*)"$/) do |content|
  expect(page).to have_content content
end
