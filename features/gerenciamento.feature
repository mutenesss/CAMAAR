Feature: Manage Questionnaires
  As an admin
  I want to create and manage questionnaires
  So that I can evaluate students and classes

  Scenario: Accessing the gerenciamento index page
    Given I am on the gerenciamento index page
    Then I should see the gerenciamento dashboard

  Scenario: Accessing the new questionnaire form
    Given I am on the gerenciamento index page
    When I click on the button "Enviar Formulários"
    Then I should be on the new questionnaire page
    And I should see the list of available classes
    And I should see the list of available templates

  Scenario: Successfully creating a questionnaire
    Given I am on the new questionnaire page
    When I fill in "Nome" with "Avaliação 1"
    And I select a class from the dropdown
    And I select a template from the dropdown
    And I click on "Criar Formulário"
    Then I should see "Formulário criado com sucesso!"
    And I should be redirected to the gerenciamento index page

  Scenario: Failing to create a questionnaire due to missing fields
    Given I am on the new questionnaire page
    When I leave the "Nome" field blank
    And I click on the button "Criar Formulário"
    Then I should see the error message "Erro ao criar questionário"
    And I should remain on the new questionnaire page
