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
      | id  | name                | user_id | is_approved | primary_contact | description |
      | 1   | Test Organization 1 | 1       | true        | John Smith      | a           |
      | 2   | Test Organization 2 | 2       | true        | John Smith      | a           |
      | 3   | Test Organization 3 | 3       | false       | John Smith      | a           |

    Given these Campaigns:
      | id | name    | description  | goal   | start_date  | organization_id | is_active | is_featured |
      | 1  | Apples  | apple farm   | 50000  | 2017-08-09  | 1               | true      | false       |
      | 2  | Bananas | banana farm  | 80000  | 2017-01-10  | 1               | false     | true        |
      | 3  | Oranges | orange farm  | 50000  | 2017-08-17  | 1               | true      | true        |

    Given these CampaignChanges:
    | id | name    | description  | goal   | organization_id | campaign_id | action | start_date  |
    | 1  | Coconuts| coconut farm | 70000  | 1               | nil         | CREATE | 2017-09-09  |
    | 2  | Bananas | banana party | 80000  | 1               | 2           | UPDATE | 2017-09-09  |
    | 3  | Oranges | orange farm  | 50000  | 1               | 3           | DELETE | 2017-08-17  |

    Given I am signed in as Test Organization 1

  Scenario: Update a running campaign from the campaign's own page
    Given I am on Test Organization 1's page
    When I click on my campaign "Apples"
    Then I should see "apple farm"
    And I should see "$50,000"
    And I should see the image "default"
    When I click on "Edit"
    And I fill in "Description" with "apple and pear farm"
    And I fill in "Funding Goal" with "60000"
    And I attach the file "applefarm.jpg" to "Image"
    And I press "Submit"
    Then I should see 'successfully submitted for approval!'
    And I should see that the campaign "Apples" has a goal of "$50,000"
    When I click "Pending Change" for "Apples"
    Then I should see 'apple and pear farm'
    And I should see "$60,000"

  Scenario: Update a running campaign from the organization's profile page
    Given I am on Test Organization 1's page
    Then I should see "Apples"
    When I click "Edit" for "Apples"
    And I fill in "Description" with "apple and pear farm"
    And I attach the file "applefarm.jpg" to "Image"
    And I press "Submit"
    Then I should see 'successfully submitted for approval!'
    And I should see that the campaign "Apples" has a goal of "$50,000"
    When I click "Pending Change" for "Apples"
    Then I should see 'apple and pear farm'

  Scenario: Update a pending campaign from the organization's profile page
    Given I am on Test Organization 1's page
    Then I should see "Coconuts"
    Then I should see that the pending campaign "Coconuts" has a goal of "$70,000"
    When I click "Edit" for "Coconuts"
    And I fill in "Description" with "coconut party"
    And I attach the file "coconutfarm.jpg" to "Image"
    And I press "Submit"
    Then I should see 'successfully submitted for approval!'
    When I click on "Coconuts"
    Then I should see 'coconut party'
    And I should see the image "coconutfarm"

  Scenario: Update a running campaign that has pending changes from the organization's profile page
    Given I am on Test Organization 1's page
    Then I should see "Bananas"
    When I click "Edit" for "Bananas"
    And I fill in "Funding Goal" with "90000"
    And I press "Submit"
    Then I should see 'successfully submitted for approval!'
    Then I should see "Bananas"
    And I should see that the campaign "Bananas" has a goal of "$80,000"
    When I click "Pending Change" for "Bananas"
    And I should see "$90,000"

  Scenario: Update a running campaign that has pending changes from the campaign change show page
    Given I am on Test Organization 1's page
    Then I should see "Bananas"
    When I click "Pending Change" for "Bananas"
    And I click on "Edit"
    And I fill in "Funding Goal" with "90000"
    And I press "Submit"
    Then I should see 'successfully submitted for approval!'
    Then I should see "Bananas"
    And I should see that the campaign "Bananas" has a goal of "$80,000"
    When I click "Pending Change" for "Bananas"
    And I should see "$90,000"

  Scenario: Update a pending campaign that has a pending deletion (pending deletion should be removed)
    Given I am on Test Organization 1's page
    Then I should see "Oranges"
    When I click "Pending Deletion" for "Oranges"
    Then I should see "We have requested the admin to delete this campaign."
    When I go to Test Organization 1's page
    And I click "Edit" for "Oranges"
    And I fill in "Funding Goal" with "12345"
    And I press "Submit"
    Then I should see that the campaign "Oranges" has a goal of "$50,000"
    When I click "Pending Change" for "Oranges"
    Then I should see "$12,345"
