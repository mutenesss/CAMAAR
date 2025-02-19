require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe '#password_reset' do
    let(:user) { create(:user, Email: 'user@example.com') }
    let(:token) { 'abc123' }
    let(:mail) { described_class.password_reset(user, token).deliver_now }

    it 'define as variáveis de instância corretamente' do
      expect(mail.body.encoded).to include(token)
    end

    it 'envia o e-mail para o endereço correto' do
      expect(mail.to).to eq([user.Email])
    end

    it 'define o assunto corretamente' do
      expect(mail.subject).to eq('Redefinição de Senha')
    end
  end

  describe '#forgot_password' do
  let(:user) { FactoryBot.create(:user, Email: 'user@example.com') } # Usando FactoryBot para criar um usuário
  let(:token) { 'abc123' }
  let(:mail) { described_class.forgot_password(user, token).deliver_now }

  it 'define as variáveis de instância corretamente' do
    expect(mail.body.encoded).to include(user.Nome) # Verifica se o e-mail do usuário está no corpo
    expect(mail.body.encoded).to include(token) # Verifica se o token está no corpo
    expect(mail.body.encoded).to include(edit_password_reset_url(token: token)) # Verifica se a URL está no corpo
  end

  it 'envia o e-mail para o endereço correto' do
    expect(mail.to).to eq([user.Email])
  end

  it 'define o assunto corretamente' do
    expect(mail.subject).to eq('Redefinição de Senha')
  end
end
end