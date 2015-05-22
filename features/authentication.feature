Feature: Authentication
  In order to verify their identity
  A user
  Should be able to sign up for and sign in to the application, as well as recover
  any forgotten passwords.

  Scenario: Sign Up
    Given I am not signed in
    When I visit "/sign_up"
    And I fill out the sign up form
    Then I should exist as a user
    And I should be signed in
    And I should receive a welcome email

  Scenario: Signing In
    Given I am not signed in
    And A user exists with some password
    When I sign in
    Then I should be signed in

  Scenario: Signing Out
    Given I am signed in
    When I click the link "Sign out"
    Then I should be signed out

  Scenario: Password recovery with valid email
    Given I am not signed in
    And I have forgotten my password
    And I visit "/sign_in"
    When I click the link "Forgot password?"
    Then I should see "Reset your password"
    When I give a valid email to password recovery
    Then A password recovery email should be sent to that email

  Scenario: Password recovery with invalid email
    Given I am not signed in
    And I have forgotten my password
    And I visit "/sign_in"
    When I click the link "Forgot password?"
    Then I should see "Reset your password"
    When I give an invalid email to password recovery
    Then No password recovery email should be sent

  Scenario: Reset password
