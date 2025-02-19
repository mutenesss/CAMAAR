Feature: Forgot Password
  As a user
  I want to reset my password
  So that I can regain access to my account

  Scenario: Request password reset for an existing email
    Given I am on the forgot password page
    When I enter a registered email
    Then I should see the message "Instruções de redefinição de senha enviadas para o seu e-mail."

  Scenario: Request password reset for a non-existing email
    Given I am on the forgot password page
    When I enter an unregistered email
    Then I should see the message "Email não encontrado."
