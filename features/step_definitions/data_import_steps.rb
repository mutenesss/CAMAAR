Given("I am on the data import page") do
  visit new_data_import_path
end

When("I upload a valid courses JSON file") do
  attach_file("file", Rails.root.join("classes.json"))
  click_button "Importar"
end

When("I upload a valid class JSON file") do
  attach_file("file", Rails.root.join("class_members.json"))
  click_button "Importar"
end

When("I try to import without selecting a file") do
  click_button "Importar"
end

When("I upload an invalid JSON file") do
  attach_file("file", Rails.root.join("error_classes.json"))
  click_button "Importar"
end

Then("I should get the message {string}") do |message|
  expect(page).to have_content(message)
end

Then("I should be redirected to the Gerenciamento home page") do
  expect(page).to have_current_path(gerenciamento_index_path)
end

Then("the database should contain the imported courses data") do
  expect(Materia.count).to be > 0
end

Then("the database should contain the imported class data") do
  imported_class = Turma.find_by(codigo: "CIC0097")
  expect(imported_class).not_to be_nil  
end

