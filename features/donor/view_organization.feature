Feature: Donor Viewing an Organization
  As a donor
  So I can find out more about an organization
  I want to see the profile of an organization and its list of campaigns in the past, both active and inactive, without any edit/delete button

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
      | 3  | Oranges | orange farm  | 50000  | 2017-08-17  | 2               | true      | true        |

    Given these CampaignChanges:
      | id | name    | description  | goal   | organization_id | campaign_id | start_date  |
      | 1  | Coconuts| coconut farm | 70000  | 1               | nil         | 2017-09-09  |
      | 2  | Bananas | banana party | 80000  | 1               | 2           | 2017-09-09  |

    Given I am signed out

  Scenario: Donor viewing an organization's page
    Given I am on Test Organization 1's page
    Then I should see "Test Organization 1"
    Then I should see "Apples"
    Then I should see "Bananas"
    Then the campaign table rows should not contain "Edit"
    Then the campaign table rows should not contain "Delete"
