Feature: Organization viewing all their campaigns
  As a donor
  So I can donate and support Campaigns
  I want to view a list of all campaigns available

  Background: the website already has some existing campaigns for a particular organization
    Given these Campaigns:
      | name    | description  | goal   | start_date  | organization_id | is_active | is_approved | is_featured |
      | Apples  | apple farm   | 50000  | 2017-08-09  | 1               | true      | false       | false       |
      | Bananas | banana farm  | 80000  | 2017-01-10  | 1               | false     | true        | true        |
      | Oranges | orange farm  | 50000  | 2017-08-17  | 2               | true      | true        | true        |

  Scenario: View all the campaigns
    Given I am on the home page
    Then I should see "Apples" has a goal of "$50000"
    And I should see "Bananas" has a goal of "$80000"
    And I should see "Oranges" has a goal of "$50000"
