Feature: option to be anonymous
  As a donor
  So I can donate directly from the website
  I want to be able to use electronic services to make payments, and decide if I want to be anonymous

  Background:

  Scenario: Donor wants to remain anonymous
  Given I am on the form page on Madison County Gives
  When I check I want to be anonymous
  Then I should not see myself on the Donations and updates