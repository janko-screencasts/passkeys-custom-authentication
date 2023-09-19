require "test_helper"

class WebauthnControllerTest < ActionDispatch::IntegrationTest
  test "should get setup" do
    get webauthn_setup_url
    assert_response :success
  end

  test "should get remove" do
    get webauthn_remove_url
    assert_response :success
  end

  test "should get auth" do
    get webauthn_auth_url
    assert_response :success
  end
end
