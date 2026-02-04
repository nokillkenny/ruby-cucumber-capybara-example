@dynamic
Feature: Dynamic content handling
  Scenario: Wait for dynamically loaded content
    Given I am on the dynamic loading page
    When I click start
    Then I see "Hello World!" after loading
