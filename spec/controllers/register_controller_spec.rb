require 'rails_helper'

RSpec.feature 'User Registration', type: :feature do

  let(:user) { FactoryBot.create(:user) }

  # Cenário 1: Visitar a página de registro
  scenario 'Visitar a página de registro' do
    visit register_path
    expect(page).to have_content('Cadastro')
  end

  # Cenário 2: Registrar um novo usuário com sucesso
  scenario 'Registrar um novo usuário com sucesso' do
    visit register_path

    fill_in 'Email', with: "novo@usuário.com"
    click_button 'Solicitar registro'

    expect(page).to have_content('Email de confirmação enviado. Verifique sua caixa de entrada.')
    expect(ActionMailer::Base.deliveries.count).to eq(1) # Verifica se o e-mail foi enviado
  end

  # Cenário 3: Tentar registrar um e-mail já cadastrado
  scenario 'Tentar registrar um e-mail já cadastrado' do
    visit register_path

    fill_in 'Email', with: user.Email
    click_button 'Solicitar registro'

    expect(page).to have_content('Email já cadastrado.')
  end

  # Cenário 4: Confirmar o registro com um token válido
  scenario 'Confirmar o registro com um token válido' do
    visit register_path

    fill_in 'Email', with: "Usario@user.com"
    click_button 'Solicitar registro'

    token = RegistrationToken.find_by(email: "Usario@user.com")&.token
    visit edit_register_path(token)

    fill_in 'Nome',with: "Meu Nome"
    fill_in 'Matricula',with: "939291"
    fill_in 'Role',with: "user"
    fill_in 'Password',with: "123"
    fill_in 'Password confirmation',with: "123"

    click_button 'Definir senha'


    expect(page).to have_content('Cadastro realizado com sucesso!')
    expect(user.reload.confirmation_token).to be_nil # Verifica se o token foi limpo
  end

  # Cenário 5: Tentar confirmar o registro com um token inválido
  scenario 'Tentar confirmar o registro com um token inválido' do
    invalid_token = 'token_invalido'
    visit edit_register_path(invalid_token)

    expect(page).to have_content('Token inválido ou expirado.')
  end
end