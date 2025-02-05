# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

Avaliacao.create!([
  { nome_materia: "Matemática", semestre: "2024/1", professor: "Prof. João" },
  { nome_materia: "Física", semestre: "2024/2", professor: "Prof. Maria" },
  { nome_materia: "Química", semestre: "2023/2", professor: "Prof. Carlos" },
  { nome_materia: "História", semestre: "2024/1", professor: "Prof. Ana" },
  { nome_materia: "Geografia", semestre: "2023/1", professor: "Prof. Paulo" }
])
