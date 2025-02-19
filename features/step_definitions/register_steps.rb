Given("I have a valid registration token") do
  @token = RegistrationToken.create!(email: "newuser@example.com", token: "valid_token")
end

Given("I have an invalid registration token") do
  @token = RegistrationToken.create!(email: "expired@example.com", token: "expired_token", created_at: 3.days.ago)
end

Given("I have a registered email") do
  User.create!(Nome: "Existing User", Email: "existinguser@example.com", Matricula: "987654321", Role: "discente",Senha: "password123")
end

When("I fill out the registration form") do
  visit edit_register_path(token: "valid_token")
  fill_in "Nome", with: "New User"
  fill_in "Matrícula", with: "123456789"
  fill_in "Role", with: "discente"
  fill_in "Senha", with: "password123"
  fill_in "Confirmação de Senha", with: "password123"
end

When("I visit the registration page with the valid token") do
  visit edit_register_path(token: "valid_token")
end

When("I submit the form") do
  click_button "Registrar"
end

When("I visit the registration page with the invalid token") do
  visit edit_register_path(token: "expired_token")
end

When("I request a registration token for the registered email") do
  visit register_path
  fill_in "Email", with: "existinguser@example.com"
  click_button "Enviar"
end

Then("I should see {string}") do |message|
  expect(page).to have_content(message)
end
