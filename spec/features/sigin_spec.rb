require 'rails_helper'

RSpec.feature 'User Login', type: :feature do
    let(:user) { FactoryBot.create(:user) }

  # Cenário 1
  scenario 'Usuário faz login com email' do
    visit login_path
    fill_in 'Email ou Matrícula', with: user.Email
    fill_in 'Senha', with: user.Senha
    click_button 'Entrar'

    expect(page).to have_content('Logado com sucesso')
  end

  # Cenário 2
  scenario 'Usuário faz login com matrícula' do
    visit login_path
    fill_in 'Email ou Matrícula', with: user.Matricula
    fill_in 'Senha', with: user.Senha
    click_button 'Entrar'

    expect(page).to have_content('Logado com sucesso')
  end

  # Cenário 3
  scenario 'Usuário tenta fazer login com senha incorreta' do
    visit login_path
    fill_in 'Email ou Matrícula', with: user.Email
    fill_in 'Senha', with: 'senhaerrada'
    click_button 'Entrar'

    expect(page).to have_content('Senha incorreta.')
  end

  # Cenário 4
  scenario 'Usuário tenta fazer login com email/matrícula inexistente' do
    visit login_path
    fill_in 'Email ou Matrícula', with: 'naoexiste@email.com'
    fill_in 'Senha', with: 'qualquercoisa'
    click_button 'Entrar'

    expect(page).to have_content('E-mail ou matrícula não encontrados.')
  end
end