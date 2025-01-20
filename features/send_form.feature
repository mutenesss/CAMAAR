Feature: Send Questionnaire to a Course

    As an admin,
    I want to made questionnaires available to professors and students to fill,
    So that I can eval the performance of a course.

    Background: Start from the "Gerenciamento" page

    Scenario: Sucess at sending a questionnaire
        Given I have clicked on the "Enviar Formularios" button
        And I see the "Formulario Disponiveis" page 
        When I select an item from "Formularios"
        And I press the "Enviar" button
        Then the itens selected from "Formularios" are made available to the course participants.

    Scenario: Failure at sending a questionnaire
        Given I have clicked on the "Enviar Formularios" button
        And I see the "Formulario Disponiveis" page 
        When I press the "Enviar" button
        Then I should see "Nenhum Formulario Selecionado"
        And I should be back on the "Gerenciamento" page