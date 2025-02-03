require 'rails_helper'

RSpec.feature 'Password Reset', type: :feature do
  let(:user) { create(:user, Email: 'test@example.com', Senha: 'oldpassword') }

  scenario 'Visitar a página de redefinição de senha' do
    visit new_password_reset_path
    expect(page).to have_content('Redefinir Senha')
  end

  scenario 'Redefinir senha com sucesso' do
    token = user.password_reset_tokens.create
    visit edit_password_reset_path(token.token)

    fill_in 'Nova Senha', with: 'newpassword'
    fill_in 'Confirmar Nova Senha', with: 'newpassword'
    click_button 'Salvar Nova Senha'

    expect(page).to have_content('Senha redefinida com sucesso.')
    expect(user.reload.Senha).to eq('newpassword')
  end

  scenario 'Tentar redefinir senha com senhas diferentes' do
    token = user.password_reset_tokens.create
    visit edit_password_reset_path(token.token)

    fill_in 'Nova Senha', with: 'newpassword'
    fill_in 'Confirmar Nova Senha', with: 'wrongpassword'
    click_button 'Salvar Nova Senha'

    expect(page).to have_content('As senhas não coincidem.')
    expect(user.reload.Senha).to eq('oldpassword')
  end
end