Feature: Authentication
  In order to verify their identity
  A user
  Should be able to sign up for and sign in to the application, as well as recover
  any forgotten passwords.

  Scenario: Sign Up
    Given I am not signed in
    When I visit "/sign_up"
    And I fill out "name"
    And I fill out "email"
    And I provide a password and confirmation
    When I click "Sign Up"
    Then I should exist as a user
    And I should be signed in
    And I should receive a welcome email

  Scenario: Signing In
    Given I am not signed in
    And A user exists
    When I visit "/sign_in"
    And I fill out "email" with my email
    And I fill out "password" with my password
    When I click "Sign In"
    Then I should be signed in

  Scenario: Password recovery with valid email
    Given I am not signed in
    And I have forgotten my password
    And I visit "/sign_in"
    When I click "Forgot Password"
    Then I should see "Password Recovery"
    When I fill out "email" with a valid email
    And I click "Submit"
    Then I should see "A recovery email was sent to"
    And A password recovery email should be sent to that email

  Scenario: Password recovery with invalid email
    Given I am not signed in
    And I have forgotten my password
    And I visit "/sign_in"
    When I click "Forgot Password"
    Then I should see "Password Recovery"
    When I fill out "email" with an invalid email
    And I click "Submit"
    Then I should see "We did not find a user"
    And No password recovery email should be sent