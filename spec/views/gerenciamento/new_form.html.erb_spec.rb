require 'rails_helper'

RSpec.describe "gerenciamento/new_form", type: :view do
  let(:questionarios) { Questionarios.new }
  let(:turmas) { [
    double('Turma', codigo: 'TURMA1'),
    double('Turma', codigo: 'TURMA2')
  ] }
  let(:templates) { [
    double('Template', id: 1, nome: 'Template1'),
    double('Template', id: 2, nome: 'Template2')
  ] }

  before do
    assign(:questionarios, questionarios)
    assign(:turmas, turmas)
    assign(:templates, templates)
  end

  it "renders new form with required fields" do
    render

    assert_select "form[action=?][method=?]", create_form_gerenciamento_index_path, "post" do
      assert_select "input[name=?]", "nome"
      assert_select "select[name=?]", "turma"
      assert_select "select[name=?]", "template_base"
    end
  end

  context "with errors" do
    before do
      allow(questionarios).to receive_messages(
        errors: double(any?: true, full_messages: ['Error message'])
      )
    end

    it "displays error messages" do
      render
      expect(rendered).to have_selector('.error-messages')
      expect(rendered).to have_content('Error message')
    end
  end
end
