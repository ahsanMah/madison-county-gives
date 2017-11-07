Feature: Organization viewing all their campaigns
  As a donor
  So I can donate and support Campaigns
  I want to view a list of all campaigns available

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

  Scenario: View all the campaigns
    Given I am on the campaign index page
    Then I should see that the campaign "Apples" has a goal of "$50,000"
    And I should see that the campaign "Apples" has a start_date of "2017-08-09"
    And I should see that the campaign "Apples" has an image "default"
    And I should see that the campaign "Bananas" has a goal of "$80,000"
    And I should see that the campaign "Bananas" has a start_date of "2017-01-10"
    And I should see that the campaign "Bananas" has an image "default"
    And I should see that the campaign "Oranges" has a goal of "$50,000"
    And I should see that the campaign "Oranges" has a start_date of "2017-08-17"
    And I should see that the campaign "Oranges" has an image "default"
