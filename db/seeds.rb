# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

# db/seeds.rb

Avaliacao.create!([
  { nome_materia: "Matemática", semestre: "2024/1", professor: "Prof. João" },
  { nome_materia: "Física", semestre: "2024/2", professor: "Prof. Maria" },
  { nome_materia: "Química", semestre: "2023/2", professor: "Prof. Carlos" },
  { nome_materia: "História", semestre: "2024/1", professor: "Prof. Ana" },
  { nome_materia: "Geografia", semestre: "2023/1", professor: "Prof. Paulo" }
])


Template.create!([
  {nome: "Template 1", publico_alvo: "Discentes", semestre: "2024.2"},
  {nome: "Template 2", publico_alvo: "Discentes", semestre: "2024.2"},  
  {nome: "Template 3", publico_alvo: "Docentes", semestre: "2024.2"}
])

departamento = Departamento.create!(nome: "Teste 1")

materia = Materia.create!(
  nome: "Materia de Teste 1",
  codigo: "MT01",
  departamento: departamento # Ensure the association is set
)

Turma.create!([
  {codigo: "MT01", semestre: "2024.2", materia_id: materia.MateriaID},
  {codigo: "MT02", semestre: "2024.2", materia_id: materia.MateriaID},
  {codigo: "MT03", semestre: "2024.2", materia_id: materia.MateriaID}
])

# Error on 'password_confirmation' -> Method does not exist for User
# Is it 'confirmation_token'?
# User.create(Email: 'aluno@aluno.unb.br', Senha: 'password123', password_confirmation: 'password123')
