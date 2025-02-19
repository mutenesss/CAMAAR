Given("I am on the forgot password page") do
  visit new_password_reset_path
end

When("I enter a registered email") do
  fill_in "Email", with: "aluno@aluno.unb.br"
  click_button "Enviar"
end

When("I enter an unregistered email") do
  fill_in "Email", with: "nonexistent@example.com"
  click_button "Enviar"
end

Then("I should see the message {string}") do |message|
  expect(page).to have_content(message)
end
