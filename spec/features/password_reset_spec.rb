require 'rails_helper'

RSpec.feature 'Password Reset', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:token) { user.password_reset_tokens.create }

  # Métodos auxiliares
  def visit_password_reset_page
    visit edit_password_reset_path(token.token)
  end

  # Auxilia no preenchimento de campos
  def fill_passwords(new_password, confirmation_password)
    fill_in 'Nova Senha', with: new_password
    fill_in 'Confirmar Nova Senha', with: confirmation_password
  end

  # Click no botão submit
  def submit_password_reset_form
    click_button 'Salvar Nova Senha'
  end

  # Redefinição de senha, comum a mais de um cenário
  def redefinição_senha(older, newer, msg)
    visit_password_reset_page
    fill_passwords(older, newer)
    submit_password_reset_form

    expect(page).to have_content(msg)
  end

  # Cenário 1
  scenario 'Visitar a página de redefinição de senha' do
    visit new_password_reset_path
    expect(page).to have_content('Redefinir Senha')
  end

  # Cenário 2
  scenario 'Redefinir senha com sucesso' do
    redefinição_senha('654321','654321','Senha redefinida com sucesso.')
    expect(user.reload.Senha).to eq('654321')
  end

  # Cenário 3
  scenario 'Tentar redefinir senha com senhas diferentes' do
    redefinição_senha('123456','654321','As senhas não coincidem.')
    expect(user.reload.Senha).to eq('123456')
  end

  # Cenário 4
  scenario 'Tentar redefinir senha com token inválido ou expirado' do
    token.update(expires_at: 1.day.ago) # Expira o token
    visit_password_reset_page

    expect(page).to have_content('Link inválido ou expirado.')
  end

  # Cenário 5
  scenario 'Tentar redefinir senha sem preencher os campos obrigatórios' do
    visit_password_reset_page
    fill_passwords('', '')
    submit_password_reset_form

    expect(page).to have_content('Senha não pode ficar em branco.')
    expect(user.reload.Senha).not_to eq('')
  end

  # Cenário 6
  scenario 'Token é destruído após o uso' do
    visit_password_reset_page
    fill_passwords('654321', '654321')
    submit_password_reset_form

    expect(page).to have_content('Senha redefinida com sucesso.')
    expect { token.reload }.to raise_error(ActiveRecord::RecordNotFound) # Verifica se o token foi removido
  end

  # Cenário 7
  scenario 'Tentar redefinir a senha de outro usuário' do
    # Cria um segundo usuário
    user2 = FactoryBot.create(:user, Matricula: '999999', Email: 'outro@example.com')

    redefinição_senha('654321','654321','Senha redefinida com sucesso.')

    expect(user.reload.Senha).to eq('654321')
    expect(user2.reload.Senha).not_to eq('654321')
  end
end