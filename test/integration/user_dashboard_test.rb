require 'test_helper'

class UserDashboardTest < ActionDispatch::IntegrationTest
  test "guest cannot access dashboard" do
    visit dashboard_path

    assert page.has_content? "The page you were looking for doesn't exist"
  end
end
