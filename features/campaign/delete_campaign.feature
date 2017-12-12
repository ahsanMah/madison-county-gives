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
      | id  | name                | user_id | is_approved | primary_contact | description |
      | 1   | Test Organization 1 | 1       | true        | John Smith      | a           |
      | 2   | Test Organization 2 | 2       | true        | John Smith      | a           |
      | 3   | Test Organization 3 | 3       | false       | John Smith      | a           |

    Given these Campaigns:
      | id | name    | description  | goal   | start_date  | organization_id | is_active | is_featured |
      | 1  | Apples  | apple farm   | 50000  | 2017-08-09  | 1               | true      | false       |
      | 2  | Bananas | banana farm  | 80000  | 2017-01-10  | 1               | false     | true        |
      | 3  | Oranges | orange farm  | 50000  | 2017-08-17  | 1               | true      | true        |

    Given these CampaignChanges:
      | id | name    | description  | goal   | organization_id | campaign_id | action | start_date  |
      | 1  | Coconuts| coconut farm | 70000  | 1               | nil         | CREATE | 2017-09-09  |
      | 2  | Bananas | banana party | 80000  | 1               | 2           | UPDATE | 2017-09-09  |
      | 3  | Oranges | orange farm  | 50000  | 1               | 3           | DELETE | 2017-08-17  |

    Given I am signed in as Test Organization 1

  Scenario: Create a deletion request for a particular campaign
    Given I am on the organizations index page
    And I click on my organization "Test Organization 1" in the nav bar
    And I click on "My Organization"
    Then I should see "Apples"
    When I click on my campaign, "Apples"
    Then I should see "$50,000"
    When I follow "Delete"
    Then I should see 'We have requested the admin to remove'

  Scenario: Create a deletion request for a campaign with pending changes (pending changes should be overwritten by pending deletion)
    Given I am on Test Organization 1's page
    When I click "Delete" for "Bananas"
    Then I should see "We have requested the admin to remove"
    When I click "Pending Deletion" for "Bananas"
    Then I should see "We have requested the admin to delete this campaign."

  Scenario: Create a deletion request for a campaign with pending deletion (nothing happens; pending deletion should remain)
    Given I am on Test Organization 1's page
    When I click "Delete" for "Oranges"
    Then I should see "We have requested the admin to remove"
    When I click "Pending Deletion" for "Oranges"
    Then I should see "We have requested the admin to delete this campaign."

  Scenario: Actually delete a campaign creation request that has not yet been approved (no need for approval in this case)
    Given I am on Test Organization 1's page
    Then I should see "Campaigns Pending Approval"
    When I click "Delete" for "Coconuts"
    Then I should see "has been removed from the listing"
    Then I should not see "Campaigns Pending Approval"

  Scenario: Actually delete a not-yet-approved campaign change request to an existing campaign (no need for approval in this case)
    Given I am on Test Organization 1's page
    When I click "Pending Change" for "Bananas"
    When I click on "Delete"
    Then I should see "has been removed from the listing"
    Then I should not see "Pending Change"

  Scenario: Recall a deletion request for an existing campaign (no need for approval in this case)
    Given I am on Test Organization 1's page
    When I click "Pending Deletion" for "Oranges"
    When I click on "Recall this deletion request"
    Then I should see "has been removed from the listing"
    Then I should not see "Pending Deletion"
