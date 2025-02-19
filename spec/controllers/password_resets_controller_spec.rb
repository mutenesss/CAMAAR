require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  describe "POST #create" do
    let(:user) { create(:user, Email: "user@example.com") }

    it "envia um e-mail de redefinição de senha se o usuário existir" do
      post :create, params: { email: user.Email }

      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('Email de redefinição de senha enviado.')
      expect(user.password_reset_tokens.count).to eq(1)
    end
  end
end

RSpec.describe PasswordResetsController, type: :controller do
  describe "POST #create" do
    it "exibe um alerta quando o e-mail não for encontrado" do
      post :create, params: { email: "naoexiste@example.com" }

      expect(response).to render_template(:new)
      expect(flash[:alert]).to eq('Email não encontrado.')
    end
  end
end

