class AddNicknameToWebauthnCredentials < ActiveRecord::Migration[7.0]
  def change
    add_column :webauthn_credentials, :nickname, :string
  end
end
