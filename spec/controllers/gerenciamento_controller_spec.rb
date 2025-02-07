/require 'rails_helper'

RSpec.describe GerenciamentoController, type: :controller do
  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #new_form" do
    let(:turmas) { double('Turma') }
    let(:templates) { double('Templates') }

    before do
      allow(Turma).to receive(:all).and_return(turmas)
      allow(Templates).to receive(:all).and_return(templates)
    end

    it "assigns a new questionario and fetches turmas and templates" do
      get :new_form
      expect(assigns(:questionarios)).to be_a_new(Questionarios)
      expect(assigns(:turmas)).to eq(turmas)
      expect(assigns(:templates)).to eq(templates)
    end
  end

  describe "POST #create_form" do
    let(:questionario_params) { { nome: "Test Form", turma_id: 1, templates_id: 1 } }
    let(:questionario) { double('Questionarios') }

    context "with valid parameters" do
      before do
        allow(Questionarios).to receive(:new).and_return(questionario)
        allow(questionario).to receive(:save).and_return(true)
      end

      it "creates a new questionario and redirects" do
        post :create_form, params: { questionarios: questionario_params }
        expect(response).to redirect_to(gerenciamento_path)
        expect(flash[:notice]).to eq("Questionário criado com sucesso!")
      end
    end

    context "with invalid parameters" do
      before do
        allow(Questionarios).to receive(:new).and_return(questionario)
        allow(questionario).to receive(:save).and_return(false)
        allow(Turma).to receive(:all)
        allow(Templates).to receive(:all)
      end

      it "re-renders the new form" do
        post :create_form, params: { questionarios: questionario_params }
        expect(response).to render_template(:new_form)
      end
    end
  end
end
/