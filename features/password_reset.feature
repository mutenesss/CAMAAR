Feature: Password Reset
  As a user,
  I want to reset my password from the email I received,
  So that I can regain access to the system.

  Scenario: Successfully reset password
    Given the user has received a password reset email
    And clicks on the link in the email
    When they enter a valid new password
    And confirm the new password
    And click on "Save new password"
    Then the system should update the user's password
    And display a confirmation message: "Senha redefinida com sucesso."

  Scenario: Attempt to reset password with mismatched passwords
    Given the user has received a password reset email
    And clicks on the link in the email
    When they enter a new password
    And enter a different confirmation password
    And click on "Save new password"
    Then the system should display an error message: "As senhas não coincidem."