Feature: Add Questions to Questionnaires

    As an admin,
    I want to add questions to questionnaires,
    So that I can create questionares to eval the performance of a course.

    Background: Start from the "Gerenciamento" page

    Scenario: Sucess at adding a text based question
        Given I have clicked on the "Criar Formulario" button
        And I see the "Criacao de Formulario" page 
        When I select "Texto" from "Tipo"
        And I fill in "Pergunta" with "Pergunta"
        Then the question is added to the questionare
    
    Scenario: Sucess at adding a multiple choice question
        Given I have clicked on the "Criar Formulario" button
        And I see the "Criacao de Formulario" page 
        When I select "Escolha" from "Tipo"
        And I fill in "Opcoes" with "Opcoes Disponiveis"
        Then the question is added to the questionare
    
    Scenario: Sucess at adding a rating question
        Given I have clicked on the "Criar Formulario" button
        And I see the "Criacao de Formulario" page 
        When I select "Avalie" from "Tipo"
        And I fill in "Opcoes" with "Opcoes Disponiveis"
        Then the question is added to the questionare

    Scenario: Failure at adding any question (No Type)
        Given I have clicked on the "Criar Formulario" button
        And I see the "Criacao de Formulario" page 
        When I fill in "Opcoes" with "Opcoes Disponiveis"
        Then i should see "Tipo de pergunta nao selecionado"
    
    Scenario: Failure at adding any question (No Data - Multiple Choice)
        Given I have clicked on the "Criar Formulario" button
        And I see the "Criacao de Formulario" page 
        When I select "Escolha" from "Tipo"
        Then i should see "Escolhas não adicionadas"
    
    Scenario: Failure at adding any question (No Data - Rating)
        Given I have clicked on the "Criar Formulario" button
        And I see the "Criacao de Formulario" page 
        When I select "Avalie" from "Tipo"
        Then i should see "Item a ser avaliado nao descrito"
    
    Scenario: Failure at adding any question (No Data - Text)
        Given I have clicked on the "Criar Formulario" button
        And I see the "Criacao de Formulario" page 
        When I select "Texto" from "Tipo"
        Then i should see "Pergunta nao adicionada"