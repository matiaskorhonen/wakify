Feature: Computers
Logged in users should be able to add, list, view, edit and delete computers.

Scenario: Add computer
Given a user is logged in as "testUser"
Then the user should be able to add a computer

Scenario: List computers
Given a user is logged in as "testUser"
When a computer named "Example" has been added
Then the user should be able to view a list of computers

Scenario: View a computer
Given a user is logged in as "testUser"
When a computer named "Example" has been added
Then the user should be able to view the details of the "Example" computer

Scenario: Edit a computer
Given a user is logged in as "testUser"
When a computer named "Example" has been added
Then the user should be able to change the details of the "Example" computer

Scenario: Delete a computer
Given a user is logged in as "testUser"
When a computer named "Example" has been added
Then the user should be able to delete the "Example" computer