class DataImportController < ApplicationController
  def new
  end

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

  def import_data(data)
    data.each do |entry|
      if entry.key?("code") && entry.key?("name")
        import_materia(entry)
      elsif entry.key?("code") && entry.key?("semester")
        import_turma(entry)
      end
    end
  end

  def import_materia(entry)
    Materia.find_or_create_by(codigo: entry["code"]) do |materia|
      materia.nome = entry["name"]
    end
  end

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
