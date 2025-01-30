class CreateDb < ActiveRecord::Migration[8.0]
  def change
    create_table :users, primary_key: "UserId" do |t|
      t.string :Matricula
      t.string :Email
      t.string :Nome
      t.string :Role
      t.string :Senha
      t.timestamps
    end

    create_table :departamentos, primary_key: "DepartamentoId" do |t|
      t.string :Nome
    end

    create_table :coordenadores, primary_key: "CoordenadorId" do |t|
      t.references :departamento, foreign_key: { to_table: :departamentos }, index: true
      t.references :user, foreign_key: { to_table: :users }, index: true
    end

    create_table :materias, primary_key: "MateriaId" do |t|
      t.string :Nome
      t.string :Codigo
      t.references :departamento, foreign_key: { to_table: :departamentos }, index: true
    end

    create_table :turmas, primary_key: "TurmaId" do |t|
      t.string :Codigo
      t.string :Semestre
      t.references :materia, foreign_key: { to_table: :materias }, index: true
    end

    create_table :matriculas, primary_key: "MatriculaId" do |t|
      t.references :user, foreign_key: { to_table: :users }, index: true
      t.references :turma, foreign_key: { to_table: :turmas }, index: true
    end

    create_table :templates, primary_key: "TemplateId" do |t|
      t.string :Nome
      t.string :PublicoAlvo
      t.string :Semestre
    end

    create_table :questionarios, primary_key: "QuestionarioId" do |t|
      t.string :Nome
      t.string :Turma
      t.references :template, foreign_key: { to_table: :templates }, index: true
    end

    create_table :questaos, primary_key: "QuestaoId" do |t|
      t.string :Nome
      t.string :Texto
      t.string :Tipo
      t.references :template, foreign_key: { to_table: :templates }, index: true
    end

    create_table :questao_options, primary_key: "QuestaoOptionId" do |t|
      t.string :Nome
      t.string :Texto
      t.references :questao, foreign_key: { to_table: :questaos }, index: true
    end

    create_table :respondidos, primary_key: "RespondidoId" do |t|
      t.references :questionario, foreign_key: { to_table: :questionarios }, index: true
      t.references :user, foreign_key: { to_table: :users }, index: true
    end

    create_table :respostas, primary_key: "RespostaId" do |t|
      t.string :Valor
      t.references :questao, foreign_key: { to_table: :questaos }, index: true
      t.references :questionario, foreign_key: { to_table: :questionarios }, index: true
    end
  end
end
