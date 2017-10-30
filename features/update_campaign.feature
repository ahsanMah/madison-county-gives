Feature: Organization updating campaigns
  As an organization
  So I can change my campaign information
  I want to be able to access a particular campaign and edit it

  Background: the website already has some existing campaigns for a particular organization
    Given these Campaigns:
      | name    | description  | goal   | start_date  | organization_id | is_active | is_approved | is_featured |
      | Apples  | apple farm   | 50000  | 2017-08-09  | 1               | true      | false       | false       |
      | Bananas | banana farm  | 80000  | 2017-01-10  | 1               | false     | true        | true        |

  Scenario: Update a particular campaign
    Given I am on the organization profile page
    When I click on my own campaign, "Apples"
    Then I should see "apple farm"
    And I should see the image "default"
    When I click on "Edit Campaign"
    And I fill in "Description" with "apple and pear farm"
    And I attach the file "applefarm.jpg" to "Cover Image"
    And I press "Submit updates for approval"
    Then I should see 'Submitted updates for approval'
    Then I should see "apple and pear farm"
    And I should see the image "applefarm"
