Feature: Donation Cart functionality
	As a donor
	So that I can donate to multiple campaigns in a streamlined manner
	I want to be able to accumulate donation amounts for different campaigns in a cart and then checkout the donations

	Background: the website already has some existing campaigns
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

	Scenario: Add campaign donation to cart and checkout
		Given I am on Apples page
		When I fill in "Donation Amount" with "30"
		And I press "Donate"
		Then I should be on Summary page
		Then I should see "Apples"
		Then I should see "Bananas"
		Then I should see "$30"
		Then I should see "$40"
		When I click on "Checkout"
		Then I should be on Checkout page



		