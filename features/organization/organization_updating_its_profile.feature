Feature: Organization Updating Its Profile
  As an organization
  So I can manage the basic information in my profile
  I want to update my profile
  (essay response update is currently not supported)

  Background:
    Given these Users:
      | id | email              | password  |
      | 1  | user1@example.com  | 123456    |
      | 2  | user2@example.com  | 123456    |
      | 3  | user3@example.com  | 123456    |

    Given these Organizations:
      | id | user_id  | name               | primary_contact | address           | email         | description         | is_approved  |
      | 1  | 1        | Red Cross          | Susan Jean      | 13 Madison Ave.   | rc@gmail.com  | Disaster-relief     | true         |
      | 2  | 2        | Refugee Foundation | Neriq Mann      | 46 Raviolli Drive | we@yahoo.com  | Home for all        | true         |

    Given I am signed in as Refugee Foundation

  Scenario: Update organization details as a user authorized by that organization
    Given I am on the All organizations page
    Then I should see that "Refugee Foundation" has "Edit organization details"
    When I click on "Edit organization details"
    And I fill in "Description" with "refuge for displaced peoples"
    And I attach the file "rfgFoundation.jpg" to "Cover Image"
    And I press "Submit updated information for approval"
    Then I should see "Submitted updates for approval"
    Then I should see "refuge for displaced peoples"
    And I should see the image "rfgFoundation"
