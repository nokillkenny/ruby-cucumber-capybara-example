@login
Feature: Authentication flows
  Scenario: Successful login with valid credentials
    Given I am on the login page
    When I enter valid credentials
    And I submit the login form
    Then I see the secure area

  Scenario: Failed login with invalid credentials
    Given I am on the login page
    When I enter invalid credentials
    And I submit the login form
    Then I see an error message
