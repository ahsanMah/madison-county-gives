Feature: Admin Access Control
  As an admin
  So I can manage the website
  I want to be able to access the admin interface only when logged in as admin

  Background: the website already has some existing users, organizations and campaigns
    Given these Users:
      | id | email              | password  | is_admin |
      | 1  | user1@example.com  | 123456    | false    |
      | 2  | user2@example.com  | 123456    | false    |
      | 3  | user3@example.com  | 123456    | false    |
      | 4  | admin@example.com  | 123456    | true     |

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

  Scenario: Admin can access admin pages
    Given I am signed in as admin@example.com
    Then I am on the admin dashboard page
    When I go to the admin database page
    Then I am on the admin database page

  Scenario: Regular user cannot access admin pages
    Given I am signed in as Test Organization 1
    When I go to the admin dashboard page
    Then I am on the home page
    When I go to the admin database page
    Then I am on the home page

  Scenario: Logged-out user cannot access admin pages
    Given I am signed out
    When I go to the admin dashboard page
    Then I am on the home page
    When I go to the admin database page
    Then I am on the home page
