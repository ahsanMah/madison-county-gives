Feature: Organization Creating Campaign
  As an organization
  So I can raise money on the website
  I want to be able to post my campaign on the website for others to donate to

  Background: the website already has some existing campaigns for a particular organization
    Given these Campaigns:
      | name    | description  | goal   | start_date  | organization_id | is_active | is_featured |
      | Apples  | apple farm   | 50000  | 2017-08-09  | 1               | true      | false       |
      | Bananas | banana farm  | 80000  | 2017-01-10  | 1               | false     | true        |

  Scenario: Create a new campaign without an image
    Given I am on the create new campaign page
    When I fill in the following:
      | Campaign Name     |  Food Cupboard            |
      | Description       |  Emergency Food Storage   |
      | Funding Goal      |  10000                    |
      | Start Date        |  2017-10-30               |

    When I press "Submit Proposal"
    Then I should be on organization profile page
    And I should see 'Campaign proposal for "Food Cupboard" submitted'
    And I should see that "Food Cupboard" has a goal of "$10000"
    And I should see that "Food Cupboard" has a start date of "10/30/17"
    And I should see that "Food Cupboard" has an image "default.png"

  Scenario: Create a new campaign with an image
    Given I am on the create new campaign page
    When I fill in the following:
      | Campaign Name     |  Food Cupboard            |
      | Description       |  Emergency Food Storage   |
      | Funding Goal      |  10000                    |
      | Start Date        |  2017-10-30               |
      
    When I attach the file "foodcupboard.jpg" to "Cover Image"
    When I press "Submit Campaign Proposal"
    Then I should be on organization profile page
    And I should see 'Campaign proposal for "Food Cupboard" submitted'
    And I should see that "Food Cupboard" has a goal of "$10000"
    And I should see that "Food Cupboard" has a start date of "10/30/17"
    And I should see that "Food Cupboard" has an image "foodcupboard.jpg"
