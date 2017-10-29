Feature: Organization Managing Campaign
  As an organization
  So I can look at a particular campaign
  I want to be able to view a particular campaign

  Background: the website already has some existing campaigns for a particular organization
  Given these Campaigns:
    | name    | description  | goal   | start_date  | organization_id | is_active | is_approved | is_featured |
    | Apples  | apple farm   | 50000  | 2017-08-09  | 1               | true      | false       | false       |
    | Bananas | banana farm  | 80000  | 2017-01-10  | 1               | false     | true        | true        |

  Scenario: View a particular campaign
    Given I am on the organization profile page
    When I click on my own campaign, "Apples"
    Then I should see "apple farm"
    And I should see the image "default"
