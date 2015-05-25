Feature: Announcements
  In order to get up to date information about HackCWRU
  A user should be able to read announcements.

  In order to provide up to date information about HackCWRU
  A staff member should be able to create, update, and delete announcements.

  Background:
    Given I am signed in

  Scenario: View announcements list
    Given There are 10 announcements
    When I visit "/announcements"
    Then I should see 10 announcements
    And The announcements should be listed in chronological order

  Scenario: View an announcement
    Given An announcement exists
    When I visit that announcement's show page
    Then I should see that announcement

  Scenario: View an announcement from the list
    Given An announcement exists
    When I visit "/announcements"
    And I click on a random announcement
    Then I should see that announcement

  Scenario: Create an announcement
    Given I am staff
    When I visit "/announcements/new"
    And I fill out the announcement form
    Then There should be a new announcement
    And I should see that announcement

  Scenario: Update an announcement
    Given I am staff
    And An announcement exists
    When I visit that announcement's edit page
    And I change its title
    Then That announcement should have the new title
    And I should see that announcement

  Scenario: Delete an announcement
    Given I am staff
    When TODO
    Then TODO

  Scenario: Non-staff cannot create announcement
    Given I am not staff
    When I visit "/announcements/new"
    Then I should be denied access

  Scenario: Non-staff cannot update announcement
    Given I am not staff
    And An announcement exists
    When I visit that announcement's edit page
    Then I should be denied access

  Scenario: Non-staff cannnot delete announcement
    Given I am not staff
    When TODO
    Then TODO
