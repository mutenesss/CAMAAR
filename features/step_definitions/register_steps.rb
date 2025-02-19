Given("I have a valid registration token") do
  @token = RegistrationToken.create!(email: "newuser@example.com", token: "valid_token")
end

Given("I have an invalid registration token") do
  @token = RegistrationToken.create!(email: "expired@example.com", token: "expired_token", created_at: 3.days.ago)
end

When("I fill out the registration form") do
  visit edit_register_path(token: "valid_token")
  fill_in "Nome", with: "New User"
  fill_in "Matrícula", with: "123456"
  fill_in "Senha", with: "password123"
  fill_in "Confirmação de Senha", with: "password123"
end

When("I submit the form") do
  click_button "Registrar"
end

Then("I should see {string}") do |message|
  expect(page).to have_content(message)
end
