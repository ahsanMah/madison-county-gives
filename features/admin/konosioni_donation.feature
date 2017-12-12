Feature: Admin Adding Konosioni Donation
  As an admin
  So I can display Konosioni’s contribution and give due credit
  I want to be able to add donations to campaigns while identified as "Konosioni"

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

    Scenario: Admin should be able submit a donation
      Given I am signed in as admin@example.com
      Then I am on the admin dashboard page
      When I fill the donation form with the following:
        | Amount          | 80  |
      And I click submit for the donation form
      Then I should see "Konosioni payment successfully saved!"
