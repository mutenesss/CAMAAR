Feature: Template Management

  Rule: Administrators can manage templates for questionnaires, ensuring their actions reflect system requirements.

    Scenario: Successful template creation
      Given I am an administrator logged into the system
      And I have accessed the template management page
      When I click "Create Template"
      And enter "Template Name" in the title field
      And add a "Radio" question with options "Option 1, Option 2"
      And add a "Text" question with placeholder "Your answer here"
      And click "Save Template"
      Then the template is successfully saved
      And it appears as a card in the template list with the correct title

    Scenario: Failed template creation due to missing data
      Given I am an administrator logged into the system
      And I have accessed the template management page
      When I click "Create Template"
      And leave the title field blank
      And click "Save Template"
      Then the system shows an error message "Title and at least one question are required"

    Scenario: Successful template editing
      Given I am an administrator logged into the system
      And there is a template named "Template 1" in the template list
      When I click the "Edit" icon on the "Template 1" card
      And modify the title to "Updated Template Name"
      And add an additional option "Option 3" to an existing "Radio" question
      And click "Save Changes"
      Then the template is successfully updated
      And its card in the template list displays the updated title
      And previously created questionnaires remain unchanged

    Scenario: Failed template editing due to invalid data
      Given I am an administrator logged into the system
      And there is a template named "Template 1" in the template list
      When I click the "Edit" icon on the "Template 1" card
      And leave the title field blank
      And click "Save Changes"
      Then the system shows an error message "All required fields must be filled out"

    Scenario: Viewing all created templates
      Given I am an administrator logged into the system
      When I access the template management page
      Then I see a grid of template cards
      And each card displays the template name and options to edit or delete

    Scenario: No templates available
      Given I am an administrator logged into the system
      And there are no templates created
      When I access the template management page
      Then the system displays a message "No templates available"

    Scenario: Successful template deletion
      Given I am an administrator logged into the system
      And there is a template named "Template 1" in the template list
      When I click the "Delete" icon on the "Template 1" card
      And confirm the deletion in the dialog
      Then the template is removed from the system
      And it no longer appears in the template list
      And questionnaires created using this template are unaffected

    Scenario: Failed template deletion due to usage
      Given I am an administrator logged into the system
      And there is a template currently in use
      When I attempt to delete the template
      Then the system shows an error message "Cannot delete a template that is in use"
