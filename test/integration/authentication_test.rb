require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest
  test "guest login with github" do
    VCR.use_cassette("apicurious") do
      visit root_path
      assert_equal User.count, 0

      click_on "Login with GitHub to Start"

      assert_equal dashboard_path, current_path
      assert_equal User.count, 1
    end
  end

  test "user logout" do
    VCR.use_cassette("apicurious") do
      visit root_path
      click_on "Login with GitHub to Start"

      assert_equal dashboard_path, current_path

      click_on "Logout"
      assert_equal root_path, current_path
    end
  end

  test "when user visits root goes to dashboard page" do
    VCR.use_cassette("apicurious") do
      user = create(:user)
      ApplicationController.any_instance.stubs(:current_user).returns(user)

      visit root_path

      assert_equal dashboard_path, current_path
    end
  end
end
