require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest
  test "guest login with valid data" do
    visit root_path
    click_on "Login with github"
  end

  test "user logout" do
    assert true
  end
end
