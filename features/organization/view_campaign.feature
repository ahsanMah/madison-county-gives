Feature: Organization viewing specific campaign
  As an organization
  So I can look at a particular campaign
  I want to be able to view a particular campaign

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
      | id | name    | description  | goal   | organization_id | campaign_id |  action  | start_date  |
      | 1  | Coconuts| coconut farm | 70000  | 1               | nil         |  CREATE  | 2017-09-09  |
      | 2  | Bananas | banana party | 80000  | 1               | 2           |  UPDATE  | 2017-09-09  |

    Given I am signed in as Test Organization 1

  Scenario: View a particular campaign
    Given I am on the home page
    And I follow "Test Organization 1"
    And I click on "My Organization"
    Then I should be on Test Organization 1's page
    When I click on the campaign "Apples"
    Then I should see "apple farm"
    And I should see the image "default"
    And I should see "$50,000"
    And I should see "2017-08-09"

  Scenario: View a pending campaign update
    Given I am on the home page
    And I follow "Test Organization 1"
    And I click on "My Organization"
    Then I should be on Test Organization 1's page
    When I click on the campaign request "Coconuts"
    Then I should see "coconut farm"
