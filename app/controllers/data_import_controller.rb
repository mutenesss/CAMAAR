# Controller para importação de dados.
#
# Permite importar dados de matérias, turmas e usuários a partir de um arquivo JSON.
class DataImportController < ApplicationController
  # Renderiza a página de upload de arquivo.
  def new
  end

  # Processa o arquivo enviado e importa os dados.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Redireciona para a página de gerenciamento.
  #
  # Efeitos Colaterais:
  #   Realiza importação e criação de dados no banco.
  def create
    file = params[:file]
    if file.present?
      data = JSON.parse(file.read)
      import_data(data)
      flash[:notice] = "Dados importados com sucesso!"
    else
      flash[:alert] = "Nenhum arquivo selecionado."
    end
    redirect_to gerenciamento_index_url
  end

  private

  # Processa os dados do arquivo JSON.
  #
  # Argumentos:
  #   data (Array): Dados a serem importados.
  #
  # Retorna:
  #   Nenhum.
  #
  # Efeitos Colaterais:
  #   Chama métodos para importar matérias e turmas.
  def import_data(data)
    data.each do |entry|
      if entry.key?("code") && entry.key?("name")
        import_materia(entry)
      elsif entry.key?("code") && entry.key?("semester")
        import_turma(entry)
      end
    end
  end

  # Importa dados de matéria.
  #
  # Argumentos:
  #   entry (Hash): Dados da matéria.
  #
  # Retorna:
  #   Nenhum.
  #
  # Efeitos Colaterais:
  #   Cria ou atualiza a matéria no banco de dados.
  def import_materia(entry)
    Materia.find_or_create_by(codigo: entry["code"]) do |materia|
      materia.nome = entry["name"]
    end
  end

  # Importa dados de turma, departamento e usuários.
  #
  # Argumentos:
  #   entry (Hash): Dados da turma.
  #
  # Retorna:
  #   Nenhum.
  #
  # Efeitos Colaterais:
  #   Cria ou atualiza registros de Turma, Departamento e User.
  def import_turma(entry)
    Turma.find_or_create_by(codigo: entry["code"], semestre: entry["semester"])
    Departamento.find_or_create_by(nome: entry.dig("docente", "departamento"))
    
    User.find_or_create_by(Matricula: entry.dig("docente", "usuario")) do |user|
      user.Nome = entry.dig("docente", "nome")
      user.Email = entry.dig("docente", "email")
      user.Role = "docente"
    end

    entry["dicente"].each do |dicente|
      User.find_or_create_by(Matricula: dicente["matricula"]) do |user|
        user.Nome = dicente["nome"]
        user.Email = dicente["email"]
        user.Role = "dicente"
      end
    end
  end
end
