require 'rails_helper'

RSpec.feature 'Criar Formulario', type: :feature do
  #let(:user) { FactoryBot.create(:user) }
  let!(:departamento) { FactoryBot.create(:departamento) }
  let!(:turma) { FactoryBot.create(:turma) }
  let!(:template) { FactoryBot.create(:template) }

  before do
    # Simulate logged in user
    # visit new_sigin_path
    # fill_in 'Email ou Matrícula', with: user.email
    # fill_in 'Senha', with: user.senha
    # click_button 'Entrar'
  end

  # Cenário 1
  scenario 'Usuário acessa página de criação de formulário' do
    visit new_form_gerenciamento_index_path
    expect(page).to have_content('Criação de Formulário')
    expect(page).to have_field('questionario[nome]')
    expect(page).to have_select('questionario[turma_id]')
    expect(page).to have_select('questionario[template_id]')
  end

  # Cenário 2
  scenario 'Usuário cria formulário com dados válidos' do
    visit new_form_gerenciamento_index_path
    fill_in 'questionario[nome]', with: 'Formulário de Teste'
    select turma.codigo, from: 'questionario[turma_id]'
    select template.nome, from: 'questionario[template_id]'
    click_button 'Criar Formulário'

    expect(page).to have_content('Questionário criado com sucesso!')
    expect(current_path).to eq(gerenciamento_index_path)
  end

  # Cenário 3
  scenario 'Usuário tenta criar formulário sem nome' do
    visit new_form_gerenciamento_index_path
    select turma.codigo, from: 'questionario[turma_id]'
    select template.nome, from: 'questionario[template_id]'
    click_button 'Criar Formulário'

    expect(page).to have_content("Nome can't be blank")
    expect(current_path).to eq(create_form_gerenciamento_index_path)
  end

  # Cenário 4
  scenario 'Usuário navega através do sidebar' do
    visit new_form_gerenciamento_index_path
    
    click_link 'Avaliações'
    expect(current_path).to eq(root_path)
    
    visit new_form_gerenciamento_index_path
    click_link 'Gerenciamento'
    expect(current_path).to eq(gerenciamento_index_path)
  end
end