Feature: Creating an Organization
  As an organization
  So I can raise money
  I want to sign up for my organization by filling out basic information and answering short essay questions, and ask admin for approval

  Background: The website has pre-existing organizations and long-response questions for the sign-up process
    Given these ShortQuestions:
      | text                                                      |
      | What is the your organization's principle goal?           |
      | How does this benefit people in need in Madison County?   |

    Given these Organizations:
      | name               | primary_contact | address           | email         | short_responses     | description         | image | is_approved  | Campaigns |
      | Red Cross          | Susan Jean      | 13 Madison Ave.   | rc@gmail.com  | Yes                 | Disaster-relief     |       | true         |           |
      | Refugee Foundation | Neriq Mann      | 46 Raviolli Drive | we@yahoo.com  | Not that long       | Home for all        |       | true         |           |

    Scenario: Petition MadisonGives for a new organization to display
      Given I am on the home page
      When I click on "Create an organization"
      Then I should be on the organization register page
      When I fill in the following:
        | Organization Name     | Youth Education          |
        | Primary Contact       | Mary Canta               |
        | Address               | 48 Easton St.            |
        | Email                 | school@hamilton.edu      |
        | Short Responses       | Short indeed             |
        | Description           | Schooling for kids       |
      And I press "Submit Organization Registration"
      Then I should be on the All Organizations page
      And I should see "Organization pending approval.  Contact Julie for details!"
      And I should see that "Red Cross" has a description of "Disaster-relief"
      And I should see that "Refugee Foundation" has a description of "Home for all" 