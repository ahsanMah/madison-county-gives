Feature: Donor Viewing an Organization
  As a donor
  So I can find out more about an organization
  I want to see the profile of an organization and its list of campaigns in the past, both active and inactive, without any edit/delete button

  Background: the website already has some existing users, organizations and campaigns
    Given these Users:
      | id | email              | password  |
      | 1  | user1@example.com  | 142857    |
      | 2  | user2@example.com  | 285714    |
      | 3  | user3@example.com  | 428571    |

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

  Scenario: Donor viewing an organization's page
    Given I am on Test Organization 1's page
    Then I should see "Test Organization 1"
    Then I should see "Apples"
    Then I should see "Bananas"
    Then I should not see "Edit"
    Then I should not see "Delete"
