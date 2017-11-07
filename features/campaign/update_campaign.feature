Feature: Organization updating campaigns
  As an organization
  So I can change my campaign information
  I want to be able to access a particular campaign and edit it

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

    Given I am signed in as Test Organization 1

  Scenario: Update a campaign from the campaign's own page
    Given I am on Test Organization 1's page
    When I click on my campaign "Apples"
    Then I should see "apple farm"
    And I should see the image "default"
    When I click on "Edit campaign details"
    And I fill in "Description" with "apple and pear farm"
    And I attach the file "applefarm.jpg" to "Image"
    And I press "Submit Proposal"
    Then I should see 'successfully submitted for approval!'
    Then I should see "apple and pear farm"
    And I should see the image "applefarm"

  Scenario: Update a campaign from the organization's profile page
    Given I am on Test Organization 1's page
    Then I should see "Apples"
    When I click on "edit" for "Apples"
    And I fill in "Description" with "apple and pear farm"
    And I attach the file "applefarm.jpg" to "Image"
    And I press "Submit Proposal"
    Then I should see 'successfully submitted for approval!'
    Then I should see "apple and pear farm"
    And I should see the image "applefarm"
