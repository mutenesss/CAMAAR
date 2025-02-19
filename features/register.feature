Feature: User Registration
  As a new user
  I want to register an account
  So that I can access the system

  Scenario: Register with a valid token
    Given I have a valid registration token
    When I visit the registration page with the valid token
    And I fill out the registration form
    And I submit the form
    Then I should see "Cadastro realizado com sucesso! Faça login."

  Scenario: Register with an invalid token
    Given I have an invalid registration token
    When I visit the registration page with the invalid token
    Then I should see "Token inválido ou expirado."

  Scenario: Register with an already registered email
    Given I have a registered email
    When I request a registration token for the registered email
    Then I should see "Email já cadastrado."
