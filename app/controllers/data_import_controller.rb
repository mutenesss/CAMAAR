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
  #   Caso ocorra um erro, exibe uma mensagem de erro na página de gerenciamento.
  def create
    file = params[:file]
    if file.present?
      begin
        data = JSON.parse(file.read)
        import_data(data)
        flash[:notice] = "Dados importados com sucesso!"
      rescue JSON::ParserError
        flash[:alert] = "Erro ao processar o arquivo: JSON inválido"
      end
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
    departamento_codigo = entry["code"][0, 3]
    departamento = Departamento.find_or_create_by(sigla: departamento_codigo)

    Materia.find_or_create_by(codigo: entry["code"]) do |materia|
      materia.nome = entry["name"]
      materia.departamento = departamento
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
    departamento_codigo = entry["code"][0, 3]
    departamento = Departamento.find_or_create_by(sigla: departamento_codigo)

    materia = Materia.find_or_create_by(codigo: entry["code"]) do |materia|
      materia.departamento = departamento
    end

    Turma.find_or_create_by(codigo: entry["code"], semestre: entry["semester"]) do |turma|
      turma.materia = materia
    end

    User.find_or_create_by(Matricula: entry.dig("docente", "usuario")) do |user|
      user.Nome = entry.dig("docente", "nome")
      user.Email = entry.dig("docente", "email")
      user.Role = "docente"
    end

    entry["dicente"].each do |discente|
      User.find_or_create_by(Matricula: discente["matricula"]) do |user|
        user.Nome = discente["nome"]
        user.Email = discente["email"]
        user.Role = "discente"
      end
    end
  end
end
