Feature: Donation Cart functionality
	As a donor
	So that I can donate to multiple campaigns in a streamlined manner
	I want to be able to accumulate donation amounts for different campaigns in a cart and then checkout the donations

	Background: the website already has some existing campaigns for a particular organization
	Given these Users:
      | id | email              | password  |
      | 1  | user1@example.com  | 123456    |
      | 2  | user2@example.com  | 123456    |
      | 3  | user3@example.com  | 123456    |

     Given these Organizations:
      | id | user_id  | name               | primary_contact | address           | description         | is_approved  |
      | 1  | 1        | Red Cross          | Susan Jean      | 13 Madison Ave.   | Disaster-relief     | true         |
      | 2  | 2        | Refugee Foundation | Neriq Mann      | 46 Raviolli Drive | Home for all        | true         |

    Given these Campaigns:
      | id | name    | description  | goal   | start_date  | organization_id | is_active | is_featured |
      | 1  | Apples  | apple farm   | 50000  | 2017-08-09  | 1               | true      | false       |
      | 2  | Bananas | banana farm  | 80000  | 2017-01-10  | 1               | false     | true        |
      | 3  | Oranges | orange farm  | 50000  | 2017-08-17  | 2               | true      | true        |

	Scenario: Add campaign donation to cart
		Given I am on the home page
		And I follow "Apples"
		When I fill in "Enter Your Pledge Amount" with "30"
		And I press "Back this"
		Then I should see "Your donation has been successfully added to the cart located in the upper right hand corner."
		When I go to the home page
		And I follow "Oranges"
		When I fill in "Enter Your Pledge Amount" with "30"
		And I press "Back this"
		Then I should see "Your donation has been successfully added to the cart located in the upper right hand corner."
		When I click on "Cart"
	    Then I should see "Donation Cart"
	    Then I should see "Total: $60.00"

	Scenario: Delete items from the cart
		Given I am on the home page
		And I follow "Apples"
		When I fill in "Enter Your Pledge Amount" with "30"
		And I press "Back this"
		Then I should see "Your donation has been successfully added to the cart located in the upper right hand corner."
		When I click on "Cart"
	    Then I should see "Donation Cart"
	    Then I should see "Total: $30.00"
	    

	Scenario: Cart should be empty upon successful payment
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
		  | BILL_POSTAL_CODE        |  13346             |
		When I check "anon"
		And I press "Proceed to payment"
		Then I should be on the home page
		And I should see "Thank you for your generous contribution!"
		When I click on "Cart"
		Then I should see "Donation Cart"
	    Then I should see "Total: $0.00"
	    Then I should not see "$30.00"
	    Then I should not see "Apples"


