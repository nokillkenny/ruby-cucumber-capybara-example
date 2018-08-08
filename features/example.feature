Feature: Search for with filters enabled
  Scenario: Login to redfin
    Given I visit redfin
    And I log in with my credentials
    When I search for the "Newport Beach, CA" in the address listing
    Then I see "Newport Beach Real Estate" in the page header
    When I apply filter details
    When I scroll down to load the filtered houses
    Then I expect all houses listed to be sold
    And I expect the price range to be between 1000000 and 2000000
    And I expect all listed homes to have 4 bedrooms