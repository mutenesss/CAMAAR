Given("the user has received a password reset email") do
  @user = User.create!(Nome: "Test User", Email: "testuser@example.com", Matricula: "123456789", Role: "discente",Senha: "oldpassword")
  @token = @user.password_reset_tokens.create!(token: "valid_token")
end

When("they enter a valid new password") do
  fill_in "Senha", with: "newpassword123"
end

When("confirm the new password") do
  fill_in "Confirmação de Senha", with: "newpassword123"
end

When("they enter a new password") do
  fill_in "Senha", with: "newpassword123"
end

When("enter a different confirmation password") do
  fill_in "Confirmação de Senha", with: "differentpassword"
end

When("click on {string}") do |button|
  click_button button
end

Then("the system should update the user's password") do
  @user.reload
  expect(@user.authenticate("newpassword123")).to be_truthy
end

Then("display a confirmation message: {string}") do |message|
  expect(page).to have_content(message)
end

Then("the system should display an error message: {string}") do |message|
  expect(page).to have_content(message)
end

And("clicks on the link in the email") do
  visit edit_password_reset_path(token: "valid_token")
end