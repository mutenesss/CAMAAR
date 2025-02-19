require 'rails_helper'

RSpec.describe DataImportController, type: :controller do
  describe "GET #new" do
    it "renders the new template" do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    let(:file_path) { Rails.root.join('classes.json') }
    let(:file) { fixture_file_upload(file_path, 'application/json') }

    context "with valid JSON file" do
      it "processes the file and redirects to gerenciamento index" do
        post :create, params: { file: file }

        expect(response).to redirect_to(gerenciamento_index_url)
        expect(flash[:notice]).to eq("Dados importados com sucesso!")
      end
    end

    context "without a file" do
      it "redirects to gerenciamento index with an error message" do
        post :create, params: { file: nil }

        expect(response).to redirect_to(gerenciamento_index_url)
        expect(flash[:alert]).to eq("Nenhum arquivo selecionado.")
      end
    end

    context "with invalid JSON format" do
      let(:invalid_file_path) { Rails.root.join('error_classes.json') }
      let(:invalid_file) { fixture_file_upload(invalid_file_path, 'application/json') }

      it "redirects to gerenciamento index with an error message" do
        post :create, params: { file: invalid_file }

        expect(response).to redirect_to(gerenciamento_index_url)
        expect(flash[:alert]).to eq("Erro ao processar o arquivo: JSON inválido")
      end
    end
  end
end
