Feature: Administrators impersonating customers
  As an administrator
  In order to help customers buy lots of products
  I want to be able to asume the identity of a customer

  Background:
    Given the admin user "Kevin Rudd" exists
    And I am logged in as the user "Kevin Rudd"
    And the customer "Julia Gillard" exists

  Scenario: Assuming a customers identity
    Given I am on the admin page
    Then I should see "Logged in as Kevin Rudd"
    When I follow "Customers"
    Then I should see "Julia Gillard"
    When I follow "Assume Identity"
    Then I should be effectively logged in as "Julia Gillard"
    And I should be on the home page
    And I should see "Julia Gillard" within the login name display

  Scenario: Viewing a page as a customer
    Given I am assuming the identity of "Julia Gillard"
    And I am on the home page
    Then I should see the return to original identity button on the page

  Scenario: Returning back to the original admin identity
    Given I am assuming the identity of "Julia Gillard"
    And I am on the home page
    When I follow the return to original identity button on the page
    Then I should be on the admin page
    And I should see "Kevin Rudd" within the login name display
