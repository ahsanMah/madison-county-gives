Feature: Organization viewing all their campaigns
  As an organization
  So I can look at all my campaigns
  I want to be able to look at a list of all past and present campaigns

  Background: the website already has some existing campaigns for a particular organization
    Given these Campaigns:
      | name    | description  | goal   | start_date  | organization_id | is_active | is_approved | is_featured |
      | Apples  | apple farm   | 50000  | 2017-08-09  | 1               | true      | false       | false       |
      | Bananas | banana farm  | 80000  | 2017-01-10  | 1               | false     | true        | true        |

  Scenario: View all my campaigns
    Given I am on the organization profile page
    Then I should see that "Apples" has a goal of "$50000"
    And I should see that "Bananas" has a goal of "$80000"

