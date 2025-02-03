class CreatePasswordResetTokens < ActiveRecord::Migration[8.0]
  def change
    create_table :password_reset_tokens do |t|
      t.integer :UserID
      t.string :token
      t.datetime :expires_at

      t.timestamps
    end
  end
end
