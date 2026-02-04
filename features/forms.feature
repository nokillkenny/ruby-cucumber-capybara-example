@forms
Feature: Form interactions
  Scenario: Checkbox toggling
    Given I am on the checkboxes page
    When I toggle the first checkbox
    Then the first checkbox state changes

  Scenario: Dropdown selection
    Given I am on the dropdown page
    When I select "Option 1" from the dropdown
    Then "Option 1" is selected
