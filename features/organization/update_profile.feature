Feature: Organization Updating Its Profile
  As an organization
  So I can manage the basic information in my profile
  I want to update my profile

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

    Given these ShortQuestions:
      | id | question                        |
      | 1  | What is your goal?              |
      | 2  | How does this benefit people?   |

    Given these ShortResponses:
      | id  | response                | short_question_id | organization_id |
      | 1   | What?                   | 1                 | 1               |

    Scenario: User can edit his/her profile
      Given I am signed in as Red Cross
      When I click on "Red Cross"
      And I click "Edit" for "Description"
      Then I should see "Disaster-relief"
      And I should see "What is your goal?"
      And I should see "What?"
      And I should see "How does this benefit people?"
      When I fill in the following:
        | Organization Name               | Red X                    |
        | How does this benefit people?   | I don't know             |
      And I press "Submit"
      Then I should see "Your changes have been submitted."
      And I should see "Red X"

    Scenario: Name cannot be blank
      Given I am signed in as Red Cross
      When I click on "Red Cross"
      And I click "Edit" for "Description"
      Then I should see "Disaster-relief"
      And I should see "What is your goal?"
      And I should see "What?"
      And I should see "How does this benefit people?"
      When I fill in the following:
        | Organization Name               |                          |
        | How does this benefit people?   | I don't know             |
      And I press "Submit"
      Then I should see "We were unable to update your organization profile. Name can't be blank"
