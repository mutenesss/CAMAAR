Feature: Data Import
  As an admin
  I want to import data from a JSON file
  So that I can populate the database efficiently

  Scenario: Successfully importing valid course JSON file
    Given I am on the data import page
    When I upload a valid courses JSON file
    Then I should be redirected to the Gerenciamento home page
    And I should get the message "Dados importados com sucesso!"
    And the database should contain the imported courses data
  
  Scenario: Successfully importing valid class JSON file
    Given I am on the data import page
    When I upload a valid class JSON file
    Then I should be redirected to the Gerenciamento home page
    And I should get the message "Dados importados com sucesso!"
    And the database should contain the imported class data

  Scenario: Attempting to import without a file
    Given I am on the data import page
    When I try to import without selecting a file
    Then I should get the message "Nenhum arquivo selecionado."
    And I should be redirected to the Gerenciamento home page

  Scenario: Attempting to import an invalid JSON file
    Given I am on the data import page
    When I upload an invalid JSON file
    Then I should get the message "Erro ao processar o arquivo: JSON inválido"
    And I should be redirected to the Gerenciamento home page
