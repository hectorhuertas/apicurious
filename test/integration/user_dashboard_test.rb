require 'test_helper'

class UserDashboardTest < ActionDispatch::IntegrationTest
  attr_reader :user

  def setup
    @user = hector
    ApplicationController.any_instance.stubs(:current_user).returns(user)
  end

  test "guest cannot access dashboard" do
    ApplicationController.any_instance.stubs(:current_user).returns(nil)

    visit dashboard_path

    assert page.has_content? "The page you were looking for doesn't exist"
  end

  test "user sees dashboard with user info" do
    visit dashboard_path

    # within('#user_')
  end
end
