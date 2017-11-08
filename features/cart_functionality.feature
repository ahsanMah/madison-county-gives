Feature: Donation Cart functionality
	As a donor
	So that I can donate to multiple campaigns in a streamlined manner
	I want to be able to accumulate donation amounts for different campaigns in a cart and then checkout the donations

	Background: the website already has some existing campaigns for a particular organization but there already is an item in the cart
		Given these Campaigns:
			| name    | description  | goal   | start_date  | organization_id | is_active | is_approved | is_featured |
			| Apples  | apple farm   | 50000  | 2017-08-09  | 1               | true      | false       | false       |
			| Bananas | banana farm  | 80000  | 2017-01-10  | 1               | false     | true        | true        |
			| Oranges | orange farm  | 50000  | 2017-08-17  | 2               | true      | true        | true        |

	Scenario: Add campaign donation to cart and checkout
		Given there is a donation for "Bananas" at "40"
		Given I am on Apples page
		When I fill in "Donation Amount" with "30"
		And I press "Donate"
		Then I should see "Thank You for your contribution!"
		Then I should see "Cart (2)"
		When I click on Cart(2) 
		Then I should be on Summary page
		Then I should see "Apples"
		Then I should see "Bananas"
		Then I should see "$30"
		Then I should see "$40"
		When I click on "Checkout"
		Then I should be on Checkout page



		