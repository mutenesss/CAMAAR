FactoryBot.define do
  factory :turmas do
    Codigo { 'MT01' }
    Semestre { '2024.2' }
    association :materias
  end
end
