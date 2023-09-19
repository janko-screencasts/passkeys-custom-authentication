class HomeController < ApplicationController
  def index
    @webauthn_params = RodauthMain.webauthn_setup_params(account_id: Current.user.id)
  end
end
