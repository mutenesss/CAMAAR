require 'rails_helper'

RSpec.describe "gerenciamento/new_form", type: :view do
  let(:questionario) { Questionario.new }
  let(:turmas) {
    [
    double('Turma', id:1, codigo: 'TURMA1'),
    double('Turma', id:2, codigo: 'TURMA2')
  ]}
  let(:templates) {
    [
    double('Template', id: 1, nome: 'Template1'),
    double('Template', id: 2, nome: 'Template2')
  ]}

  before do
    assign(:questionario, questionario)
    assign(:turmas, turmas)
    assign(:templates, templates)
  end

  it "renders new form with required fields" do
    render

    assert_select "form[action=?][method=?]", create_form_gerenciamento_index_path, "post" do
      assert_select "input[name=?]", "questionario[nome]"
      assert_select "select[name=?]", "questionario[turma_id]"
      assert_select "select[name=?]", "questionario[template_id]"
    end
  end

  context "with errors" do
    before do
      allow(questionario).to receive_messages(
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
