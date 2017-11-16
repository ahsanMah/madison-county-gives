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
    Given I am on the organizations index page
    Then I click on my organization "Refugee Foundation" in the nav bar
    And I click on "My Organization"
    Then I should see "Edit organization details"
    When I click on "Edit organization details"
    And I fill in "Description" with "refuge for displaced peoples"
    And I attach the file "foodcupboard.jpg" to "Image"
    And I press "Submit organization changes"
    Then I should see "Submitted changes for approval"
    Then I should see "refuge for displaced peoples"
    And I should see the image "foodcupboard"
