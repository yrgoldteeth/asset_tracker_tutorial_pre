Feature: Contact Management                                                                                                                                                                                                                As a user
  I should be able to manage contacts

  Scenario: List contacts as admin
    Given I am an authenticated user
    And a client "test client" exists
    And the following contacts:
      |  first_name  |  last_name  |  email_address     |  phone_number  |  recieves_email  | client_id |
      |  first1     |  last1     |  first1@name.com  |  555-555-5555  |      true           |1|
      |  first2     |  last2     |  first2@name.com  |  350-867-5309  |      false          |1|
      |  first3     |  last3     |  first3@name.com  |  123-456-7890  |      true           |1|
      |  first4     |  last4     |  first4@name.com  |  888-456-7890  |      false          |1|
    And I am on the client's contacts page
    Then I should see the following contacts:
      |  First Name  |  Last Name  |  Email Address    |  Phone Number  |  Recieves Email  |  Edit  |
      |  first1      |  last1      |  first1@name.com  |  555-555-5555  |      Yes         |  Edit  |
      |  first2      |  last2      |  first2@name.com  |  350-867-5309  |      No          |  Edit  |
      |  first3      |  last3      |  first3@name.com  |  123-456-7890  |      Yes         |  Edit  |
      |  first4      |  last4      |  first4@name.com  |  888-456-7890  |      No          |  Edit  |
    And I should see a link with text "New Contact"

  Scenario: Create a new contact
    Given I am an authenticated user
    And a client "test client" exists
    Given I am on the client's page
    When I follow "View Contacts"
    Then I follow "New Contact"
    When I fill in the following:
      | First name    | firstname    |
      | Last name     | lastname     |
      | Email address | Nice@guy.com |
      | Phone number  | 555-555-5555 |
    And I press "Create Contact"
    Then I should see "Contact created successfully"
    And I should see the following contacts:
      | First Name  | Last Name | Email Address | Phone Number |
      | firstname   | lastname  | Nice@guy.com  | 555-555-5555 |
  
  Scenario: Edit an existing contact
    Given I am an authenticated user
    And a client "test client" exists
    Given I am on the client's page
    Given the following contacts:
      |  first_name  |  last_name  |  email_address     |  phone_number  |  recieves_email  | client_id |
      |  first1     |  last1     |  first1@name.com  |  555-555-5555  |      true           |3|
      |  first2     |  last2     |  first2@name.com  |  350-867-5309  |      false          |3|
      |  first3     |  last3     |  first3@name.com  |  123-456-7890  |      true           |3|
      |  first4     |  last4     |  first4@name.com  |  888-456-7890  |      false          |3|
    When I follow "View Contacts"
    Then I follow "first1"
    And I follow "Edit Contact"
    And I check "contact_recieves_email"
    And press "Update Contact"
    Then I should see "Contact updated successfully"
    And I should see "Yes"
    
  Scenario: Delete an existing contact
    Given I am an authenticated user with an "Admin" role
    And a client "test client" exists
    Given I am on the client's page
    Given the following contacts:
      |  first_name  |  last_name  |  email_address     |  phone_number  |  recieves_email  | client_id |
      |  first1     |  last1     |  first1@name.com  |  555-555-5555  |      true           |4|
      |  first2     |  last2     |  first2@name.com  |  350-867-5309  |      false          |4|
      |  first3     |  last3     |  first3@name.com  |  123-456-7890  |      true           |4|
      |  first4     |  last4     |  first4@name.com  |  888-456-7890  |      false          |4|
    When I follow "View Contacts"
    Then I follow "first1"
    And I press "Delete Contact"
    Then show me the page
    Then I should see "Contact was successfully deleted" 
    And I should not see "first1"
