Feature: Sort Forms based on Department

    As an Admin,
    I want to see only the courses from a specific Department,
    So that I can eval the performance from that department.

    Scenario: Sucess at selecting a department
        Given I am on the "Avaliacoes" page
        When I select "Nome do Departamento" from "Departamento"
        And I press the "Organizar" button
        Then I should see only the forms from that department
    
    Scenario: Failure at selecting a department (No department selected)
        Given I am on the "Avaliacoes" page
        When I press the "Organizar" button
        Then I should see "Nenhum Filtro Selecionado"
        And I should be on the "Avaliacoes" page