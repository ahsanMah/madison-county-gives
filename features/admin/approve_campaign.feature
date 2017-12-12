Feature: Admin Campaign Approval
  As an admin
  So I can maintain the integrity of the website
  I want to review submitted campaigns in order to approve and post or reject and provide feedback

  Background: the website already has some existing users, organizations and campaigns
    Given these Users:
      | id | email              | password  | is_admin |
      | 1  | user1@example.com  | 123456    | false    |
      | 2  | user2@example.com  | 123456    | false    |
      | 3  | user3@example.com  | 123456    | false    |
      | 4  | admin@example.com  | 123456    | true     |

    Given these Organizations:
      | id  | name                | user_id | is_approved | primary_contact | description |
      | 1   | Test Organization 1 | 1       | true        | John Smith      | a           |
      | 2   | Test Organization 2 | 2       | true        | John Smith      | a           |
      | 3   | Test Organization 3 | 3       | false       | John Smith      | a           |

    Given these Campaigns:
      | id | name    | description  | goal   | start_date  | organization_id | is_active | is_featured |
      | 1  | Apples  | apple farm   | 50000  | 2017-08-09  | 1               | true      | false       |
      | 2  | Bananas | banana farm  | 80000  | 2017-01-10  | 1               | false     | true        |
      | 3  | Oranges | orange farm  | 50000  | 2017-08-17  | 2               | true      | true        |

    Given these CampaignChanges:
      | id | name    | description  | goal   | organization_id | campaign_id |  action  | start_date  |
      | 1  | Coconuts| coconut farm | 70000  | 1               | nil         |  CREATE  | 2017-09-09  |
      | 2  | Bananas | banana party | 80000  | 1               | 2           |  UPDATE  | 2017-09-09  |
      | 3  | Oranges | orange farm  | 50000  | 2               | 3           |  DELETE  | 2017-09-09  |

    Scenario: Admin should be able to approve a campaign creation request
      Given I am signed in as admin@example.com
      Then I am on the admin dashboard page
      When I click "Approve" from the "Coconuts" row
      Then I should see "Campaign has been successfully approved"

    Scenario: Admin should be able to approve a campaign update
      Given I am signed in as admin@example.com
      Then I am on the admin dashboard page
      When I click "Approve" from the "Bananas" row
      Then I should see "Campaign has been successfully approved"

    Scenario: Admin should be able to approve a campaign deletion request
      Given I am signed in as admin@example.com
      Then I am on the admin dashboard page
      When I click "Approve" from the "Oranges" row
      Then I should see "Campaign has been successfully approved"
