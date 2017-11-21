Feature: Organization Deleting Campaign
  As an organization
  So I can delete a campaign
  I want to be able to request for a deletion of a campaign

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

  Scenario: Delete a particular campaign
    Given I am on the organizations index page
    And I click on my organization "Test Organization 1" in the nav bar
    And I click on "My Organization"
    Then I should see "Apples"
    When I click on my campaign, "Apples"
    Then I should see "Funding Goal: $50,000"
    When I follow "Delete campaign"
    Then I should see 'We have requested the admin to remove'