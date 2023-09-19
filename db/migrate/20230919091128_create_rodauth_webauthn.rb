class CreateRodauthWebauthn < ActiveRecord::Migration[7.0]
  def change
    create_table :webauthn_users do |t|
      t.references :user, foreign_key: true, null: false
      t.string :webauthn_id, null: false
    end
    create_table :webauthn_credentials do |t|
      t.references :user, foreign_key: true, null: false
      t.string :webauthn_id
      t.string :public_key, null: false
      t.integer :sign_count, null: false
      t.datetime :last_use, null: false, default: -> { "CURRENT_TIMESTAMP" }

      t.index [:user_id, :webauthn_id], unique: true
    end
  end
end
