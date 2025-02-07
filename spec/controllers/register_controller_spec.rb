require 'rails_helper'

RSpec.feature 'User Registration', type: :feature do

  # Cenário 1: Visitar a página de registro
  scenario 'Visitar a página de registro' do
    visit register_path
    expect(page).to have_content('Cadastro')
  end

  # Cenário 2: Registrar um novo usuário com sucesso
  scenario 'Registrar um novo usuário com sucesso' do
    visit register_path

    fill_in 'Email', with: user.Email
    click_button 'Solicitar registro'

    expect(page).to have_content('Email de confirmação enviado. Verifique sua caixa de entrada.')
    expect(ActionMailer::Base.deliveries.count).to eq(1) # Verifica se o e-mail foi enviado
  end

  # Cenário 3: Tentar registrar um e-mail já cadastrado
  scenario 'Tentar registrar um e-mail já cadastrado' do
    visit register_path

    fill_in 'Email', with: existing_user.email
    click_button 'Solicitar registro'

    expect(page).to have_content('Email já cadastrado.')
  end

  # Cenário 4: Confirmar o registro com um token válido
  scenario 'Confirmar o registro com um token válido' do
    token = SecureRandom.hex(20)
    user.update(confirmation_token: token) # Simula um token de confirmação

    visit edit_register_path(token)

    fill_in 'Nome', with: 'João Silva'
    fill_in 'Matrícula', with: '123456'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar Senha', with: '123456'
    click_button 'Confirmar Cadastro'

    expect(page).to have_content('Cadastro concluído com sucesso!')
    expect(user.reload.confirmation_token).to be_nil # Verifica se o token foi limpo
  end

  # Cenário 5: Tentar confirmar o registro com um token inválido
  scenario 'Tentar confirmar o registro com um token inválido' do
    invalid_token = 'token_invalido'
    visit edit_register_path(invalid_token)

    expect(page).to have_content('Link inválido ou expirado.')
  end

  # Cenário 6: Tentar confirmar o registro sem preencher os campos obrigatórios
  scenario 'Tentar confirmar o registro sem preencher os campos obrigatórios' do
    token = SecureRandom.hex(20)
    user.update(confirmation_token: token) # Simula um token de confirmação

    visit edit_register_path(token)

    fill_in 'Nome', with: ''
    fill_in 'Matrícula', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirmar Senha', with: ''
    click_button 'Confirmar Cadastro'

    expect(page).to have_content('Erro ao salvar. Verifique os dados.')
  end

  # Cenário 7: Token é destruído após a confirmação do registro
  scenario 'Token é destruído após a confirmação do registro' do
    token = SecureRandom.hex(20)
    user.update(confirmation_token: token) # Simula um token de confirmação

    visit edit_register_path(token)

    fill_in 'Nome', with: 'João Silva'
    fill_in 'Matrícula', with: '123456'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar Senha', with: '123456'
    click_button 'Confirmar Cadastro'

    expect(page).to have_content('Cadastro concluído com sucesso!')
    expect(user.reload.confirmation_token).to be_nil # Verifica se o token foi limpo
  end
end