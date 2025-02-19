Given("I am on the gerenciamento index page") do
  visit gerenciamento_index_path
end

Then("I should see the gerenciamento dashboard") do
  expect(page).to have_content("Gerenciamento")
end

When("I click on {string}") do |button|
  click_link button
end

Then("I should be on the new questionnaire page") do
  expect(page).to have_current_path(new_form_gerenciamento_index_path)
end

Then("I should see the list of available classes") do
  Turma.all.each do |turma|
    expect(page).to have_content(turma.codigo)
  end
end

Then("I should see the list of available templates") do
  Template.all.each do |template|
    expect(page).to have_content(template.nome)
  end
end

Given("I am on the new questionnaire page") do
  visit new_form_gerenciamento_index_path
end

When("I fill in {string} with {string}") do |field, value|
  fill_in field, with: value
end

When("I select a class from the dropdown") do
  select Turma.first.codigo, from: "questionario_turma_id"
end

When("I select a template from the dropdown") do
  select Template.first.nome, from: "questionario_template_id"
end

When("I click on the button {string}") do |button|
  click_button button
end

Then("I should see the error message {string}") do |message|
  expect(page).to have_content(message)
end

Then("I should be redirected to the gerenciamento index page") do
  expect(page).to have_current_path(gerenciamento_index_path)
end

When("I leave the {string} field blank") do |field|
  fill_in field, with: ""
end

Then("I should remain on the new questionnaire page") do
  expect(page).to have_current_path(new_form_gerenciamento_index_path)
end
