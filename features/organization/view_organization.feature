Feature: Organization Viewing an Organization
  As an organization
  So I can find out more about an organization
  I want to see the profile of an organization and its list of campaigns in the past, both
    active and inactive, and if it is my organization (when I'm signed in), I should also
    see an edit profile button beside my profile, and edit/delete buttons beside all of my
    campaigns, and whether there are pending changes


  Background: the website already has some existing users, organizations and campaigns
    Given these Users:
      | id | email              | password  |
      | 1  | user1@example.com  | 123456    |
      | 2  | user2@example.com  | 123456    |
      | 3  | user3@example.com  | 123456    |

    Given these Organizations:
      | id  | name                | user_id | is_approved | description | primary_contact |
      | 1   | Test Organization 1 | 1       | true        | test123     | John Smith      |
      | 2   | Test Organization 2 | 2       | true        | test456     | John Smith      |
      | 3   | Test Organization 3 | 3       | false       | test789     | John Smith      |

    Given these Campaigns:
      | id | name    | description  | goal   | start_date  | organization_id | is_active | is_featured |
      | 1  | Apples  | apple farm   | 50000  | 2017-08-09  | 1               | true      | false       |
      | 2  | Bananas | banana farm  | 80000  | 2017-01-10  | 1               | false     | true        |
      | 3  | Oranges | orange farm  | 50000  | 2017-08-17  | 2               | true      | true        |

    Given these CampaignChanges:
      | id | name       | description      | goal   | start_date  | campaign_id  | action  | organization_id  |
      | 1  | Pineapple  | pineapple farm   | 10000  | 2017-11-09  |              | CREATE  | 1                |
      | 2  | Bananas    | new banana farm  | 80000  | 2017-01-10  | 2            | UPDATE  | 1                |
      | 3  | Apples     | hello            | 10     | 2017-01-10  | 1            | DELETE  | 1                |
      | 4  | Oranges    | new orange farm  | 50000  | 2017-08-17  | 3            | UPDATE  | 2                |


    Given I am signed in as Test Organization 1

  Scenario: Organization viewing an organization's page
    Given I am on Test Organization 1's page
    Then I should see "Test Organization 1"
    Then I should see "test123"
    Then I should see "Edit" in the organization's profile
    Then I should see "Apples"
    Then I should see "Bananas"
    Then the campaign cards should contain "Edit"
    Then the campaign cards should contain "Delete"
    Then I should see "Pending Change"

    Given I am on Test Organization 2's page
    Then I should see "test456"
    Then I should not see "Edit" in the organization's profile
    Then I should see "Oranges"
    Then the campaign cards should not contain "Edit"
    Then the campaign cards should not contain "Delete"
    Then I should not see "Pending Change"
