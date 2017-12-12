Feature: Introduction to Madison County Gives
  As Madison County Gives
  So I can tell user what it is
  I want to have pages to present the basic info, the contact info, and FAQs

  Scenario: User clicking navbar to read about the information
    Given I am on the home page
    When I click on "About" in the nav bar
    And I click on "About Us" in the nav bar
    Then I should be on the about us page
    And I should see "About Us"
    When I click on "About" in the nav bar
    And I click on "FAQs" in the nav bar
    Then I should be on the FAQs page
    And I should see "Frequently Asked Questions"
    When I click on "About" in the nav bar
    And I click on "Contact Us" in the nav bar
    Then I should be on the contact us page
    And I should see "Contact Us"
