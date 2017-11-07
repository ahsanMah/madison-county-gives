Feature: Donor Viewing Specific Campaign
  As a donor
  So I can see more information on campaigns before I donate
  I want to see the details of the campaign, including additional information, goal, money already raised, pictures, videos, and other donors

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

  Scenario: View a particular campaign
    Given I am on the campaigns index page
    Then I should see that the campaign "Apples" has a goal of "$50,000"
    When I follow "Apples"
    Then I should see "apple farm"
    And I should see the image "default"
    And I should not see "Edit campaign details"
    And I should not see "Delete campaign"