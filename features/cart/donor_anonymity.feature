 Feature: option to be anonymous
  As a donor
  So I can donate directly from the website
  I want to be able to use electronic services to make payments, and decide if I want to be anonymous

  Background: the website already has some existing campaigns for a particular organization
    Given these Users:
      | id | email              | password  |
      | 1  | user1@example.com  | 123456    |
      | 2  | user2@example.com  | 123456    |
      | 3  | user3@example.com  | 123456    |

    Given these Organizations:
      | id  | name                | user_id | is_approved |
      | 1   | Test Organization 1 | 1       | true        |
      | 2   | Test Organization 2 | 2       | true        |
      | 3   | Test Organization 3 | 3       | false       |

    Given these Campaigns:
      | id | name    | description  | goal   | start_date  | organization_id | is_active | is_featured |
      | 1  | Apples  | apple farm   | 50000  | 2017-08-09  | 1               | true      | false       |
      | 2  | Bananas | banana farm  | 80000  | 2017-01-10  | 1               | false     | true        |
      | 3  | Oranges | orange farm  | 50000  | 2017-08-17  | 2               | true      | true        |

  Scenario: Donor wants to remain anonymous
    Given I am on the home page
	  And I follow "Apples"
	  When I fill in "Donation Amount" with "30"
	  And I press "Donate"
	  Then I should see "Thank You for your contribution!"


	  Then I should be on Summary page
	  Then I should see "Apples"
	  Then I should see "$30"
	  When I click on "Checkout"
	  Then I should be on Checkout page
    When I fill in "First Name" with "Bob"
    When I fill in "Last Name" with "Builder"
    When I fill in "Email" with "bbuilder@colgate.edu"
    When I fill in "Phone Number" with "123-456-7891"
    When I check "Anonymous?"
    When I press "Submit"
    Then I should be on "TouchNet" page
    Then I should see "Please select a payment method and enter an amount"
    When I go to Apples page
    Then I should not see "Andrew"
    And I should see "Anonymous"
    And I should see "$40"



