Feature: Create Questionnaire

    As an admin,
    I want to create questionnaires to professors and students,
    So that I can eval the performance of a course.

    Background: Start from the "Gerenciamento" page

    Scenario: Sucess at creating a questionnaire for a professor
        Given I have clicked on the "Criar Formulario" button
        And I see the "Criacao de Formulario" page 
        When I select "Docente" from "Publico_Alvo"
        And I have filled in "Dados do Formulario" with "Informacoes"
        And I press the "Criar" button
        Then I should be on the "Gerenciamento" page
        And I should see "Sucesso ao criar o formulario"
    
    Scenario: Sucess at creating a questionnaire for a student
        Given I have clicked on the "Criar Formulario" button
        And I see the "Criacao de Formulario" page 
        When I select "Discente" from "Publico_Alvo"
        And I have filled in "Dados do Questionario" with "Informacoes"
        And I press the "Criar" button
        Then I should be on the "Gerenciamento" page
        And I should see "Sucesso ao criar o formulario"
    
    Scenario: Sucess at creating a questionnaire for all participants in a course
        Given I have clicked on the "Criar Formulario" button
        And I see the "Criacao de Formulario" page 
        When I select "Todos" from "Publico_Alvo"
        And I have filled in "Dados do Questionario" with "Informacoes"
        And I press the "Criar" button
        Then I should be on the "Gerenciamento" page
        And I should see "Sucesso ao criar o formulario"
    


    Scenario: Failure at creating a questionnaire (No questions)
        Given I have clicked on the "Criar Formulario" button
        And I see the "Criacao de Formulario" page
        When I press the "Criar" button
        Then I should be on the "Gerenciamento" page
        And I should see "Falha ao criar o formulario"
    
    Scenario: Failure at creating a questionnaire (No target audience)
        Given I have clicked on the "Criar Formulario" button
        And I see the "Criacao de Formulario" page
        When I have filled in "Dados do Questionario" with "Informacoes"
        And I press the "Criar" button
        Then I should be on the "Gerenciamento" page
        And I should see "Falha ao criar o formulario"