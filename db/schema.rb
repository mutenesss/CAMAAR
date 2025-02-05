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

ActiveRecord::Schema[8.0].define(version: 2025_02_05_074323) do
  create_table "avaliacaos", force: :cascade do |t|
    t.string "nome_materia"
    t.string "semestre"
    t.string "professor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coordenadors", primary_key: "CoordenadorID", force: :cascade do |t|
    t.integer "departamentos_id"
    t.integer "users_id"
    t.index ["departamentos_id"], name: "index_coordenadors_on_departamentos_id"
    t.index ["users_id"], name: "index_coordenadors_on_users_id"
  end

  create_table "departamentos", primary_key: "DepartamentoID", force: :cascade do |t|
    t.string "Nome"
  end

  create_table "formularios", force: :cascade do |t|
    t.integer "avaliacao_id"
    t.text "resposta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "materias", primary_key: "MateriaID", force: :cascade do |t|
    t.string "Nome"
    t.string "Codigo"
    t.integer "departamento_id"
    t.index ["departamento_id"], name: "index_materias_on_departamento_id"
  end

  create_table "matriculas", primary_key: "MatriculaID", force: :cascade do |t|
    t.integer "user_id"
    t.integer "turma_id"
    t.index ["turma_id"], name: "index_matriculas_on_turma_id"
    t.index ["user_id"], name: "index_matriculas_on_user_id"
  end

  create_table "password_reset_tokens", force: :cascade do |t|
    t.integer "UserID"
    t.string "token"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questaooptions", primary_key: "QuestaoOptionID", force: :cascade do |t|
    t.string "Nome"
    t.string "Texto"
    t.integer "questao_id"
    t.index ["questao_id"], name: "index_questaooptions_on_questao_id"
  end

  create_table "questaos", primary_key: "QuestaoID", force: :cascade do |t|
    t.string "Nome"
    t.string "Texto"
    t.string "Tipo"
    t.integer "template_id"
    t.index ["template_id"], name: "index_questaos_on_template_id"
  end

  create_table "questionarios", primary_key: "QuestionarioID", force: :cascade do |t|
    t.string "Nome"
    t.string "Turma"
    t.integer "template_id"
    t.index ["template_id"], name: "index_questionarios_on_template_id"
  end

  create_table "respondidos", primary_key: "RespondidoID", force: :cascade do |t|
    t.integer "questionario_id"
    t.integer "user_id"
    t.index ["questionario_id"], name: "index_respondidos_on_questionario_id"
    t.index ["user_id"], name: "index_respondidos_on_user_id"
  end

  create_table "respostas", primary_key: "RespostaID", force: :cascade do |t|
    t.string "Valor"
    t.integer "questao_id"
    t.integer "respondido_id"
    t.index ["questao_id"], name: "index_respostas_on_questao_id"
    t.index ["respondido_id"], name: "index_respostas_on_respondido_id"
  end

  create_table "templates", primary_key: "TemplateID", force: :cascade do |t|
    t.string "Nome"
    t.string "PublicoAlvo"
    t.string "Semestre"
  end

  create_table "turmas", primary_key: "TurmaID", force: :cascade do |t|
    t.string "Codigo"
    t.string "Semestre"
    t.integer "materia_id"
    t.index ["materia_id"], name: "index_turmas_on_materia_id"
  end

  create_table "users", primary_key: "UserID", force: :cascade do |t|
    t.string "Matricula"
    t.string "Email"
    t.string "Nome"
    t.string "Role"
    t.string "Senha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "coordenadors", "departamentos", column: "departamentos_id"
  add_foreign_key "coordenadors", "users", column: "users_id"
  add_foreign_key "materias", "departamentos"
  add_foreign_key "matriculas", "turmas"
  add_foreign_key "matriculas", "users"
  add_foreign_key "questaooptions", "questaos"
  add_foreign_key "questaos", "templates"
  add_foreign_key "questionarios", "templates"
  add_foreign_key "respondidos", "questionarios"
  add_foreign_key "respondidos", "users"
  add_foreign_key "respostas", "questaos"
  add_foreign_key "respostas", "respondidos"
  add_foreign_key "turmas", "materia", column: "materia_id"
end
