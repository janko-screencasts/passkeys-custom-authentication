class WebauthnController < ApplicationController
  skip_before_action :authenticate, only: [:login]

  def setup
    RodauthMain.webauthn_setup(
      account_id: Current.user.id,
      webauthn_setup: params[:webauthn_setup],
      webauthn_setup_challenge: params[:webauthn_setup_challenge],
      webauthn_setup_challenge_hmac: params[:webauthn_setup_challenge_hmac],
      params: { "nickname" => params[:nickname] }
    )

    redirect_to root_path, notice: "Passkey successfully created"
  rescue Rodauth::InternalRequestError => error
    redirect_to root_path, alert: error.flash
  end

  def login
    user_id = RodauthMain.webauthn_login(
      webauthn_auth: params[:webauthn_auth],
      webauthn_auth_challenge: params[:webauthn_auth_challenge],
      webauthn_auth_challenge_hmac: params[:webauthn_auth_challenge_hmac],
    )

    @session = Session.create!(user_id: user_id)
    cookies.signed.permanent[:session_token] = { value: @session.id, httponly: true }

    redirect_to root_path, notice: "Signed in successfully"
  rescue Rodauth::InternalRequestError => error
    redirect_to sign_in_path, alert: error.flash
  end

  def remove
    RodauthMain.webauthn_remove(
      account_id: Current.user.id,
      webauthn_remove: params[:webauthn_id]
    )

    redirect_to root_path, notice: "Passkey successfully deleted"
  end
end
