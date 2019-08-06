# frozen_string_literal: true

require "application_system_test_case"
require "webauthn/fake_client"

class AddCredentialFlowTest < ApplicationSystemTestCase
  test "add credential with human interaction" do
    register_user
    # Human uses USB security key

    find(:xpath, "//input[@id='credential_nickname']").fill_in(with: "Touch ID")
    click_on "Add Credential"
    # Human uses Touch ID sensor

    assert_text 'Touch ID'
    assert_text 'USB key'
  end

  test "add fake credentials" do
    fake_origin = ENV['WEBAUTHN_ORIGIN']
    fake_client = WebAuthn::FakeClient.new(fake_origin)

    fixed_challenge = SecureRandom.random_bytes(32)
    WebAuthn::CredentialOptions.stub_any_instance :challenge, fixed_challenge do
      fake_credentials = fake_client.create(challenge: fixed_challenge)
      register_user(fake_credentials: fake_credentials)
    end

    fixed_challenge = SecureRandom.random_bytes(32)
    WebAuthn::CredentialOptions.stub_any_instance :challenge, fixed_challenge do
      fake_credentials = fake_client.create(challenge: fixed_challenge)
      stub_create(fake_credentials)

      find(:xpath, "//input[@id='credential_nickname']").fill_in(with: "Touch ID")
      click_on "Add Credential"
      wait_for_async_request
    end

    assert_text 'Touch ID'
    assert_text 'USB key'
  end
end
