# Migration para criação das tabelas do banco de dados
class CreateDb < ActiveRecord::Migration[8.0]
  #Criação das tabelas
  def change
    # Criação da tabela users (usuários)
    create_table :users, primary_key: "UserID" do |t|
      t.string "Matricula"  # Matrícula do usuário
      t.string "Email"      # Email do usuário
      t.string "Nome"       # Nome do usuário
      t.string "Role"       # Cargo ou função do usuário
      t.string "Senha"      # Senha do usuário
      t.timestamps
    end

    # Criação da tabela departamentos (departamentos)
    create_table :departamentos, primary_key: "DepartamentoID" do |t|
      t.string "Nome"       # Nome do departamento
    end

    # Criação da tabela templates (modelos de questionários)
    create_table :templates, primary_key: "TemplateID" do |t|
      t.string "Nome"       # Nome do template
      t.string "PublicoAlvo" # Público-alvo do template
      t.string "Semestre"    # Semestre de utilização do template
    end

    # Criação da tabela coordenadors (coordenadores)
    create_table :coordenadors, primary_key: "CoordenadorID" do |t|
      t.belongs_to :departamento, foreign_key: true  # Relaciona com departamento
      t.belongs_to :user, foreign_key: true          # Relaciona com usuário (coordenador)
    end

    # Criação da tabela materia (disciplinas)
    create_table :materia, primary_key: "MateriaID" do |t|
      t.string "Nome"      # Nome da disciplina
      t.string "Codigo"    # Código da disciplina
      t.belongs_to :departamento, foreign_key: true  # Relaciona com departamento
    end

    # Criação da tabela turmas (turmas de disciplinas)
    create_table :turmas, primary_key: "TurmaID" do |t|
      t.string "Codigo"    # Código da turma
      t.string "Semestre"  # Semestre em que a turma é oferecida
      t.belongs_to :materia, foreign_key: true  # Relaciona com a matéria
    end

    # Criação da tabela matriculas (matrículas de alunos em turmas)
    create_table :matriculas, primary_key: "MatriculaID" do |t|
      t.belongs_to :user, foreign_key: true  # Relaciona com usuário (aluno)
      t.belongs_to :turma, foreign_key: true # Relaciona com turma
    end

    # Criação da tabela questionarios (questionários aplicados)
    create_table :questionarios, primary_key: "QuestionarioID" do |t|
      t.string "Nome"  # Nome do questionário
      t.belongs_to :turma, foreign_key: true  # Relaciona com a turma
      t.belongs_to :template, foreign_key: true  # Relaciona com o template
    end

    # Criação da tabela respondidos (questionários respondidos pelos usuários)
    create_table :respondidos, primary_key: "RespondidoID" do |t|
      t.belongs_to :questionario, foreign_key: true  # Relaciona com o questionário
      t.belongs_to :user, foreign_key: true  # Relaciona com o usuário
    end

    # Criação da tabela questaos (questões dentro dos templates)
    create_table :questaos, primary_key: "QuestaoID" do |t|
      t.string "Nome"    # Nome da questão
      t.string "Texto"   # Texto da questão
      t.string "Tipo"    # Tipo da questão (ex: múltipla escolha)
      t.belongs_to :template, foreign_key: true  # Relaciona com o template
    end

    # Criação da tabela questaooptions (opções de resposta para questões)
    create_table :questaooptions, primary_key: "QuestaoOptionID" do |t|
      t.string "Nome"    # Nome da opção de resposta
      t.string "Texto"   # Texto da opção de resposta
      t.belongs_to :questao, foreign_key: true  # Relaciona com a questão
    end

    # Criação da tabela respostas (respostas dadas pelos usuários)
    create_table :respostas, primary_key: "RespostaID" do |t|
      t.string "Valor"  # Valor da resposta
      t.belongs_to :questao, foreign_key: true  # Relaciona com a questão
      t.belongs_to :respondido, foreign_key: true  # Relaciona com a resposta dada
    end
  end
end
