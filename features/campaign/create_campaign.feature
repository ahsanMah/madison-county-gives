Feature: Organization Creating Campaign
  As an organization
  So I can raise money on the website
  I want to be able to post my campaign on the website for others to donate to

  Background: the website already has some existing users, organizations and campaigns
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

    Given these CampaignChanges:
      | id | name    | description  | goal   | organization_id | campaign_id |
      | 1  | Coconuts| coconut farm | 70000  | 1               | nil         |
      | 2  | Bananas | banana party | 80000  | 1               | 2           |

    Given I am signed in as Test Organization 1

  Scenario: Create a new campaign without an image
    Given I am on the create new campaign page
    When I fill in the following:
      | Campaign Name                           |  Food Cupboard            |
      | Description                             |  Emergency Food Storage   |
      | Funding Goal                            |  10000                    |
      | Expected start date for campaign        |  2017-10-30               |

    When I press "Submit Proposal"
    Then I should see 'Campaign proposal for "Food Cupboard" successfully submitted for approval!'
    And I should see that the campaign "Food Cupboard" has a goal of "$10,000"
    And I should see that the campaign "Food Cupboard" has a start_date of "2017-10-30"
    And I should see that the campaign "Food Cupboard" has an image "default"

  Scenario: Create a new campaign with an image
    Given I am on the create new campaign page
    When I fill in the following:
      | Campaign Name                           |  Food Cupboard            |
      | Description                             |  Emergency Food Storage   |
      | Funding Goal                            |  10000                    |
      | Expected start date for campaign        |  2017-10-30               |

    When I attach the file "foodcupboard.jpg" to "Image"
    When I press "Submit Proposal"
    Then I should see 'Campaign proposal for "Food Cupboard" successfully submitted for approval!'
    And I should see that the campaign "Food Cupboard" has a goal of "$10,000"
    And I should see that the campaign "Food Cupboard" has a start_date of "2017-10-30"
    And I should see that the campaign "Food Cupboard" has an image "foodcupboard"
