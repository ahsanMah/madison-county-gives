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

    Scenario: Fill out form and get redirected to Touchnet
      Given I am on the home page
      And I click on "Cart Checkout"
      When I fill in the following: 
        | Full Name                |  Bob Yu         |
        | Email Address            |  bob@gmail.com  |
        | Street Address 1         |  s1             |
        | Street Address 2         |  s2             |
        | City                     |  Camel          |
      And I press "Proceed to payment"
     


