Feature: link to touchnet to make donation
  As a donor
  So that I can donate to a cause I believe in
  I want to be able to click a link, go and go to touchnet

  Background:

  Scenario: Click the link and go to touchnet
  Given I am on a campgain profile
  When I fill in "name" with "bob"
  And I fill in "amount" with "$500"
  And I click "make a donation"
  Then I should see the touchnet webpage
  And I should see "bob" in "name"
  And I should see "500" in amount