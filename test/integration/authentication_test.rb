require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest
  test "guest login with valid data" do
    skip
    # needs mocking github login
  end

  test "user logout" do
    skip
    # needs mocking github login
  end

  test "user goes to root page" do
    user = create(:user)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit root_path

    assert_equal dashboard_path, current_path
  end
end
