Feature: Organization Managing Campaign
As a donor
So I can see more information on campaigns before I donate
I want to see the details of the campaign, including additional information, goal, money already raised, pictures, videos, and other donors

  Background: the website already has some existing campaigns for a particular organization
  Given these Campaigns:
    | name    | description  | goal   | start_date  | organization_id | is_active | is_approved | is_featured |
    | Apples  | apple farm   | 50000  | 2017-08-09  | 1               | true      | false       | false       |
    | Bananas | banana farm  | 80000  | 2017-01-10  | 1               | false     | true        | true        |
    | Oranges | orange farm  | 50000  | 2017-08-17  | 2               | true      | true        | true        |

  Scenario: View a particular campaign
    Given I am on the home page
    Then I should see that "Apples" has a goal of "$50000"
    When I click on my own campaign, "Apples"
    Then I should see "apple farm"
    And I should see the image "default"
