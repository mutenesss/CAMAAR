Feature: User Registration
  As a new user
  I want to register an account
  So that I can access the system

  Scenario: Register with a valid token
    Given I have a valid registration token
    When I fill out the registration form
    And I submit the form
    Then I should see "Cadastro realizado com sucesso! Faça login."

  Scenario: Register with an invalid token
    Given I have an invalid registration token
    When I try to register
    Then I should see "Token inválido ou expirado."
