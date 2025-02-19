# filepath: /home/erick/Workspace/Current/ES/Projeto/CAMAAR/features/step_definitions/data_import_steps_test.rb
require 'rails_helper'

RSpec.describe 'Data Import Steps', type: :feature do
  before do
    visit new_data_import_path
  end

  context 'when uploading a valid JSON file' do
    it 'imports the file successfully' do
      attach_file('file', Rails.root.join('classes.json'))
      click_button 'Importar'
      expect(page).to have_content('Importação realizada com sucesso')
      expect(page).to have_current_path(gerenciamento_index_path)
      expect(Turma.count).to be > 0
      expect(Materia.count).to be > 0
      expect(User.count).to be > 0
    end
  end

  context 'when trying to import without selecting a file' do
    it 'shows an error message' do
      click_button 'Importar'
      expect(page).to have_content('Nenhum arquivo selecionado')
    end
  end

  context 'when uploading an invalid JSON file' do
    it 'shows an error message' do
      attach_file('file', Rails.root.join('error_classes.json'))
      click_button 'Importar'
      expect(page).to have_content('Erro ao importar o arquivo')
    end
  end
end