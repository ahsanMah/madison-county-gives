Feature: Updating Organization Details
  As an organization
  So I can manage the basic information in my profile
  I want to update my profile
  (essay response update is currently not supported)

  Background:
    Given these Organizations:
      Given these Organizations:
      | name               | primary_contact | address           | email         | short_responses     | description         | image | is_approved  | Campaigns |
      | Red Cross          | Susan Jean      | 13 Madison Ave.   | rc@gmail.com  | Yes                 | Disaster-relief     |       | true         |           |
      | Refugee Foundation | Neriq Mann      | 46 Raviolli Drive | we@yahoo.com  | Not that long       | Home for all        |       | true         |           |

      Scenario: Update organization details as a user authorized by that organization
        Given I am on the All organizations page
        Given I am logged in as "Refugee Foundation"
        Then I should see that "Refugee Foundation" has "Edit organization details"
        When I click on "Edit organization details"
        And I fill in "Description" with "refuge for displaced peoples"
        And I attach the file "rfgFoundation.jpg" to "Cover Image"
        And I press "Submit updated information for approval"
        Then I should see 'Submitted updates for approval'
        Then I should see "refuge for displaced peoples"
        And I should see the image "rfgFoundation"

