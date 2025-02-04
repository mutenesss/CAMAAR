require 'rails_helper'

RSpec.describe "gerenciamento/index", type: :view do
  it "displays the management page with all buttons" do
    render

    expect(rendered).to have_selector('h1', text: 'Gerenciamento')
    expect(rendered).to have_button('Importar Dados')
    expect(rendered).to have_button('Ver Templates')
    expect(rendered).to have_button('Ver Respostas')
    expect(rendered).to have_button('Criar Formulário')
  end

  it "includes sidebar navigation links" do
    render

    expect(rendered).to have_link('Avaliações')
    expect(rendered).to have_link('Gerenciamento')
  end
end
