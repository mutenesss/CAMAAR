require 'rails_helper'

RSpec.feature 'Criar Formulario', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:turma) { FactoryBot.create(:turmas) }
  let(:template) { FactoryBot.create(:template) }

  before do
    # Load Models
    Turmas
    Materias

    # Simulate logged in user
    visit new_sigin_path
    fill_in 'Email ou Matrícula', with: user.Email
    fill_in 'Senha', with: user.Senha
    click_button 'Entrar'
  end

  # Cenário 1
  scenario 'Usuário acessa página de criação de formulário' do
    visit new_form_gerenciamento_index_path
    expect(page).to have_content('Criação de Formulário')
    expect(page).to have_field('nome')
    expect(page).to have_field('turma')
    expect(page).to have_field('template_base')
  end

  # Cenário 2
  scenario 'Usuário cria formulário com dados válidos' do
    visit new_form_gerenciamento_index_path
    fill_in 'nome', with: 'Formulário de Teste'
    select turma.Codigo, from: 'turma'
    select template.Nome, from: 'template_base'
    click_button 'Criar Formulário'

    expect(page).to have_content('Questionário criado com sucesso!')
    expect(current_path).to eq(gerenciamento_index_path)
  end

  # Cenário 3
  scenario 'Usuário tenta criar formulário sem nome' do
    visit new_form_gerenciamento_index_path
    select turma.Codigo, from: 'turma'
    select template.Nome, from: 'template_base'
    click_button 'Criar Formulário'

    expect(page).to have_content('Por favor, preencha o nome do formulário')
    expect(current_path).to eq(new_form_gerenciamento_index_path)
  end

  # Cenário 4
  scenario 'Usuário navega através do sidebar' do
    visit new_form_gerenciamento_index_path
    
    click_link 'Avaliações'
    expect(current_path).to eq(avaliacoes_path)
    
    visit new_form_gerenciamento_index_path
    click_link 'Gerenciamento'
    expect(current_path).to eq(gerenciamento_index_path)
  end
end