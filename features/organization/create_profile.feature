Feature: Organization Creating Its Profile and Requesting Approval
  As an organization
  So I can raise money
  I want to sign up for my organization by filling out basic information and
    answering short essay questions, and ask admin for approval

  Background: The website has pre-existing organizations and long-response questions for the sign-up process
    Given these Users:
      | id | email              | password  |
      | 1  | user1@example.com  | 123456    |
      | 2  | user2@example.com  | 123456    |
      | 3  | user3@example.com  | 123456    |

    Given these ShortQuestions:
      | id | question                                                  |
      | 1  | What is your goal?              |
      | 2  | How does this benefit people?   |

    Given these Organizations:
      | id | user_id  | name               | primary_contact | address           | email         | description         | is_approved  |
      | 1  | 1        | Red Cross          | Susan Jean      | 13 Madison Ave.   | rc@gmail.com  | Disaster-relief     | true         |
      | 2  | 2        | Refugee Foundation | Neriq Mann      | 46 Raviolli Drive | we@yahoo.com  | Home for all        | true         |

    Scenario: User directed to organization registration if having not already done so
      Given I am on the login page
      When I fill in the following:
        | Email     | user3@example.com   |
        | Password  | 123456              |
      And I press "Log in"
      Then I should be on the create new organization page
      Then I should see "Unknown Organization"
      When I click on "Unknown Organization"
      And I click on "My Organization"
      Then I should be on the create new organization page

    Scenario: User not redirected to organization registration (and will never see it) if having already done so
      Given I am signed in as Red Cross
      Then I should not be on the create new organization page
      When I click on "Red Cross"
      And I click on "My Organization"
      Then I should not be on the create new organization page
      When I go to the create new organization page
      Then I should not be on the create new organization page

    Scenario: Petition MadisonGives to create a new organization to display
      Given I am on the login page
      When I fill in the following:
        | Email     | user3@example.com   |
        | Password  | 123456              |
      And I press "Log in"
      When I fill in the following:
        | Organization Name               | Cool Schoolz             |
        | Primary Contact                 | Mary Canta               |
        | Address                         | 48 Easton St.            |
        | Email                           | school@hamilton.edu      |
        | Description                     | Schooling for kids       |
        | What is your goal?              | I don't know.            |
        | How does this benefit people?   | What?                    |
      And I press "Submit"
      Then I should see "Your application for Cool Schoolz has been submitted. It will be approved shortly."
      And I should see "Schooling for kids"

    Scenario: Name cannot be blank
      Given I am on the login page
      When I fill in the following:
        | Email     | user3@example.com   |
        | Password  | 123456              |
      And I press "Log in"
      When I fill in the following:
        | Primary Contact                 | Mary Canta               |
        | Address                         | 48 Easton St.            |
        | Email                           | school@hamilton.edu      |
        | Description                     | Schooling for kids       |
        | What is your goal?              | I don't know.            |
        | How does this benefit people?   | What?                    |
      And I press "Submit"
      Then I should be on the create new organization page
      And I should see "We were unable to create your organization profile. Name can't be blank"

    Scenario: Image should not exceed 3 MB
      Given I am on the login page
      When I fill in the following:
        | Email     | user3@example.com   |
        | Password  | 123456              |
      And I press "Log in"
      When I fill in the following:
        | Organization Name               | Cool Schoolz             |
        | Primary Contact                 | Mary Canta               |
        | Address                         | 48 Easton St.            |
        | Email                           | school@hamilton.edu      |
        | Description                     | Schooling for kids       |
        | What is your goal?              | I don't know.            |
        | How does this benefit people?   | What?                    |
      And I attach the file "oversized_image.jpg" to "Image"
      And I press "Submit"
      Then I should be on the create new organization page
      And I should see "We were unable to create your organization profile. Image file size must be less than 3 MB."
      When I fill in the following:
        | Organization Name               | Cool Schoolz             |
        | Primary Contact                 | Mary Canta               |
        | Address                         | 48 Easton St.            |
        | Email                           | school@hamilton.edu      |
        | Description                     | Schooling for kids       |
        | What is your goal?              | I don't know.            |
        | How does this benefit people?   | What?                    |
      And I attach the file "nonoversized_image.jpg" to "Image"
      And I press "Submit"
      Then I should see "Your application for Cool Schoolz has been submitted. It will be approved shortly."
      And I should see "Schooling for kids"
