require 'test_helper'

class UserDashboardTest < ActionDispatch::IntegrationTest
  attr_reader :user

  def setup
    @user = hector
    ApplicationController.any_instance.stubs(:current_user).returns(user)
  end

  test "guest cannot access dashboard" do
      VCR.use_cassette("apicurious") do
      ApplicationController.any_instance.stubs(:current_user).returns(nil)

      visit dashboard_path

      assert page.has_content? "The page you were looking for doesn't exist"
    end
  end

  test "user sees dashboard with user info" do
    VCR.use_cassette("apicurious") do
      visit dashboard_path

      assert page.has_content? "Hector Huertas"
      assert page.has_content? "5"
      assert page.has_content? "4"
      assert page.has_content? "3"
    end
  end
end
