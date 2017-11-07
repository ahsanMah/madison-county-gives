Feature: link to touchnet to make donation
  As a donor
  So that I can donate to a cause I believe in
  I want to be able to click a link, go and go to touchnet
  
  Background:
    Scenario: Click on shopping cart and go to summary page
      Given I am on the home page
      And I click on "Cart Checkout"
      Then I should see 'contributions thus far'
      And I should see 'You have not made any contributions yet :('

    Scenario: fill out form and get redirected to touchnet
      Given I am on the home page
      And I click on "Cart Checkout"
      And I fill in "Full Name" with "Bob Yu"
      And I fill in "Email address" with "joe@gmail.com"
      And I fill in "Street Address 1" with "s1"
      And I fill in "Street Address 2" with "s2"
      And I fill in "City" with "camelton"
      And I press "Proceed to payment"
     


