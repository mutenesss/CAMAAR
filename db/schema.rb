# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_01_28_191832) do
  create_table "coordenadores", primary_key: "CoordenadorId", force: :cascade do |t|
    t.integer "departamento_id"
    t.integer "user_id"
    t.index ["departamento_id"], name: "index_coordenadores_on_departamento_id"
    t.index ["user_id"], name: "index_coordenadores_on_user_id"
  end

  create_table "departamentos", primary_key: "DepartamentoId", force: :cascade do |t|
    t.string "Nome"
  end

  create_table "materias", primary_key: "MateriaId", force: :cascade do |t|
    t.string "Nome"
    t.string "Codigo"
    t.integer "departamento_id"
    t.index ["departamento_id"], name: "index_materias_on_departamento_id"
  end

  create_table "matriculas", primary_key: "MatriculaId", force: :cascade do |t|
    t.integer "user_id"
    t.integer "turma_id"
    t.index ["turma_id"], name: "index_matriculas_on_turma_id"
    t.index ["user_id"], name: "index_matriculas_on_user_id"
  end

  create_table "questao_options", primary_key: "QuestaoOptionId", force: :cascade do |t|
    t.string "Nome"
    t.string "Texto"
    t.integer "questao_id"
    t.index ["questao_id"], name: "index_questao_options_on_questao_id"
  end

  create_table "questaos", primary_key: "QuestaoId", force: :cascade do |t|
    t.string "Nome"
    t.string "Texto"
    t.string "Tipo"
    t.integer "template_id"
    t.index ["template_id"], name: "index_questaos_on_template_id"
  end

  create_table "questionarios", primary_key: "QuestionarioId", force: :cascade do |t|
    t.string "Nome"
    t.string "Turma"
    t.integer "template_id"
    t.index ["template_id"], name: "index_questionarios_on_template_id"
  end

  create_table "respondidos", primary_key: "RespondidoId", force: :cascade do |t|
    t.integer "questionario_id"
    t.integer "user_id"
    t.index ["questionario_id"], name: "index_respondidos_on_questionario_id"
    t.index ["user_id"], name: "index_respondidos_on_user_id"
  end

  create_table "respostas", primary_key: "RespostaId", force: :cascade do |t|
    t.string "Valor"
    t.integer "questao_id"
    t.integer "questionario_id"
    t.index ["questao_id"], name: "index_respostas_on_questao_id"
    t.index ["questionario_id"], name: "index_respostas_on_questionario_id"
  end

  create_table "templates", primary_key: "TemplateId", force: :cascade do |t|
    t.string "Nome"
    t.string "PublicoAlvo"
    t.string "Semestre"
  end

  create_table "turmas", primary_key: "TurmaId", force: :cascade do |t|
    t.string "Codigo"
    t.string "Semestre"
    t.integer "materia_id"
    t.index ["materia_id"], name: "index_turmas_on_materia_id"
  end

  create_table "users", primary_key: "UserId", force: :cascade do |t|
    t.string "Matricula"
    t.string "Email"
    t.string "Nome"
    t.string "Role"
    t.string "Senha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "coordenadores", "departamentos"
  add_foreign_key "coordenadores", "users"
  add_foreign_key "materias", "departamentos"
  add_foreign_key "matriculas", "turmas"
  add_foreign_key "matriculas", "users"
  add_foreign_key "questao_options", "questaos"
  add_foreign_key "questaos", "templates"
  add_foreign_key "questionarios", "templates"
  add_foreign_key "respondidos", "questionarios"
  add_foreign_key "respondidos", "users"
  add_foreign_key "respostas", "questaos"
  add_foreign_key "respostas", "questionarios"
  add_foreign_key "turmas", "materias"
end
