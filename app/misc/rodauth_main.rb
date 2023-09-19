require "rodauth/rails"
require "sequel/core"

RodauthMain = Rodauth::Rails.lib do
  enable :webauthn, :webauthn_login, :webauthn_autofill

  db Sequel.sqlite(extensions: :activerecord_connection, keep_reference: false)

  accounts_table :users
  account_password_hash_column :password_digest

  webauthn_key_insert_hash do |credential|
    super(credential).merge(nickname: param("nickname"))
  end

  webauthn_user_ids_table :webauthn_users
  webauthn_user_ids_account_id_column :user_id

  webauthn_keys_table :webauthn_credentials
  webauthn_keys_account_id_column :user_id
end
