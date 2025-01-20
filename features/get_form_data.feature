Feature: Get Response data from a Questionnaire

    As an Admin,
    I want to download the responses from a questionnaire,
    So that I can eval the performance of a course.

    Background: Start from the "Avaliacoes" page

    Scenario: Sucess at getting data from Questionnaire (There is at least 1 answer)
        Given I have clicked on any questionnaire
        And I see the "Formulario Atual" page
        When I press on "Baixar Respostas" button
        And I fill the "Localizacao Para Download" with "Localizacao"
        Then I should start downloading a file named "Formulario"
        And I should see "Iniciando Download do Arquivo"
        And I should be on the "Avaliacoes" page

    
    Scenario: Failure at getting data from Questionnaire (No answers)
        Given I have clicked on any questionnaire
        And I see the "Formulario Atual" page
        When I press on "Baixar Respostas" button
        Then I should see "Nenhuma resposta encontrada"
        And I should be on the "Avaliacoes" page