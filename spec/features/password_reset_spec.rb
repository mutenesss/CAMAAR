require 'rails_helper'

RSpec.feature 'Password Reset', type: :feature do

  let(:user) { FactoryBot.create(:user) }

  # Cenário 1
  scenario 'Visitar a página de redefinição de senha' do
    visit new_password_reset_path
    expect(page).to have_content('Redefinir Senha')
  end

  # Cenário 2
  scenario 'Redefinir senha com sucesso' do
    token = user.password_reset_tokens.create
    visit edit_password_reset_path(token.token)

    fill_in 'Nova Senha', with: '654321'
    fill_in 'Confirmar Nova Senha', with: '654321'
    click_button 'Salvar Nova Senha'

    expect(page).to have_content('Senha redefinida com sucesso.')
    expect(user.reload.Senha).to eq('654321')
  end
  
  # Cenário 3
  scenario 'Tentar redefinir senha com senhas diferentes' do
    token = user.password_reset_tokens.create
    visit edit_password_reset_path(token.token)

    fill_in 'Nova Senha', with: '123456'
    fill_in 'Confirmar Nova Senha', with: '654321'
    click_button 'Salvar Nova Senha'

    expect(page).to have_content('As senhas não coincidem.')
    expect(user.reload.Senha).to eq('123456')
  end

   # Cenário 4
   scenario 'Tentar redefinir senha com token inválido ou expirado' do
    token = user.password_reset_tokens.create
    token.update(expires_at: 1.day.ago) # Expira o token

    visit edit_password_reset_path(token.token)

    expect(page).to have_content('Link inválido ou expirado.')
  end

  # Cenário 5
  scenario 'Tentar redefinir senha sem preencher os campos obrigatórios' do
    token = user.password_reset_tokens.create
    visit edit_password_reset_path(token.token)

    fill_in 'Nova Senha', with: ''
    fill_in 'Confirmar Nova Senha', with: ''
    click_button 'Salvar Nova Senha'

    expect(page).to have_content('Senha não pode ficar em branco.')
    expect(user.reload.Senha).not_to eq('') 
  end

    # Cenário 6:
    scenario 'Token é destruído após o uso' do
      token = user.password_reset_tokens.create
      visit edit_password_reset_path(token.token)
  
      fill_in 'Nova Senha', with: '654321'
      fill_in 'Confirmar Nova Senha', with: '654321'
      click_button 'Salvar Nova Senha'
  
      expect(page).to have_content('Senha redefinida com sucesso.')
      expect { token.reload }.to raise_error(ActiveRecord::RecordNotFound) # Verifica se o token foi removido
    end

    #Cenário 7:
    scenario 'Tentar redefinir a senha de outro usuário' do
      user2 = FactoryBot.create(:user,Matricula:'999999', Email: 'outro@example.com')
      token = user.password_reset_tokens.create
  
      visit edit_password_reset_path(token.token)
  
      # Tenta alterar a senha de outro usuário
      fill_in 'Nova Senha', with: '654321'
      fill_in 'Confirmar Nova Senha', with: '654321'
      click_button 'Salvar Nova Senha'
  
      expect(page).to have_content('Senha redefinida com sucesso.')
      expect(user.reload.Senha).to eq('654321') # Verifica se a senha do usuário correto foi alterada
      expect(user2.reload.Senha).not_to eq('654321') # Verifica que a senha do outro usuário não foi alterada
    end

end