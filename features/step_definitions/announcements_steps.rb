Given(/^There are (\d+) announcements$/) do |count|
  count = count.to_i
  actual_count = Announcement.count
  if actual_count > count
    Announcement.limit(actual_count - count).destroy_all
  elsif count > actual_count
    FactoryGirl.create_list(:announcement, (count - actual_count))
  end
  expect(Announcement.count).to be count
  @announcements = Announcement.all
end

Given(/^An announcement exists$/) do
  @announcement = Announcement.all.sample || FactoryGirl.create(:announcement)
end

When(/^I visit that announcement's (.*) page$/) do |action|
  path = case action
         when 'show'
           announcement_path(@announcement)
         when 'edit'
           edit_announcement_path(@announcement)
         end
  expect(path).to_not be nil
  visit path
end

When(/^I click on a random announcement$/) do
  announcements = all('#announcements tbody tr')
  row = announcements.sample

  show_link = row.all('td a').first
  id = show_link[:href].match(/^.*\/(\d+)$/).captures[0]
  @announcement = Announcement.find id

  show_link.click
end

Then(/^I should see that announcement$/) do
  expect(page).to have_content @announcement.title
  expect(page).to have_content @announcement.content
end

Then(/^I should see (\d+) announcements$/) do |count|
  announcements = all('#announcements tbody tr')
  expect(announcements.length).to eq count.to_i
end
