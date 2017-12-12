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
	  When I fill in "Enter Your Pledge Amount" with "30"
	  And I press "Back this"
	  Then I should see "Your donation has been successfully added to the cart located in the upper right hand corner."
    When I click on "Cart"
    Then I should see "Donation Cart"
    Then I should see "$30.00"
    When I click on "Proceed to Checkout"
    Then I should see "Billing Information"
    When I fill in the following:
      | BILL_NAME               |  Bob Yu            |
      | BILL_EMAIL_ADDRESS      |  byu@colgate.edu   |
      | BILL_STREET1            |  13 Oak Drive      |
      | BILL_CITY               |  Hamilton          |
      | BILL_POSTAL_CODE        |  13346              |
    When I check "anon"
    And I press "Proceed to payment"
    Then I should be on the home page
    And I should see "Thank you for your generous contribution!"
    When I follow "Apples"
    Then I should see "Anonymous"
    Then I should see "$30"
    Then I should not see "Bob Yu"