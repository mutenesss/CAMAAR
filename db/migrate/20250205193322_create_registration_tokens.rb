class CreateRegistrationTokens < ActiveRecord::Migration[8.0]
  def change
    create_table :registration_tokens do |t|
      t.string :email
      t.string :token
      t.datetime :expires_at

      t.timestamps
    end
  end
end
