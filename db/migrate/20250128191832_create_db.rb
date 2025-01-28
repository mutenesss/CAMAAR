class CreateDb < ActiveRecord::Migration[8.0]
  def change
    create_table :users, primary_key: "UserID" do |t|
      t.string "Matricula"
      t.string "Email"
      t.string "Nome"
      t.string "Role"
      t.string "Senha"      
      t.timestamps
    end

    create_table :departamento, primary_key: "DepartamentoID" do |t|
      t.string "Nome"
    end

    create_table :template, primary_key: "TemplateID" do |t|
      t.string "Nome"
      t.string "PublicoAlvo"
      t.string "Semestre" 
    end

    create_table :coordenador, primary_key: "CoordenadorID" do |t|
      t.belongs_to :departamento, foreign_key: true
      t.belongs_to :user, foreign_key: true
    end

    create_table :materia, primary_key: "MateriaID" do |t|
      t.string "Nome"
      t.string "Codigo"
      t.belongs_to :departamento, foreign_key: true
    end

    create_table :turma, primary_key: "TurmaID" do |t|
      t.string "Codigo"
      t.string "Semestre"
      t.belongs_to :materia, foreign_key: true
    end

    create_table :matriculas, primary_key: "MatriculaID" do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :turma, foreign_key: true
    end

    create_table :questionario, primary_key: "QuestionarioID" do |t|
      t.string "Nome"
      t.string "Turma"
      t.belongs_to :template, foreign_key: true
    end

    create_table :respondido, primary_key: "RespondidoID" do |t|
      t.belongs_to :questionario, foreign_key: true
      t.belongs_to :user, foreign_key: true
    end

    create_table :questao, primary_key: "QuestaoID" do |t|
      t.string "Nome"
      t.string "Texto"
      t.string "Tipo"
      t.belongs_to :template, foreign_key: true
    end

    create_table :questaooption, primary_key: "QuestaoOptionID" do |t|
      t.string "Nome"
      t.string "Texto"
      t.belongs_to :questao, foreign_key: true
    end

    create_table :resposta, primary_key: "RespostaID" do |t|
      t.string "Valor"
      t.belongs_to :questao, foreign_key: true
      t.belongs_to :respondido, foreign_key: true
    end
  end
end
