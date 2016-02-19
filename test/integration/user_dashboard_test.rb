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

      within('#person') do
        assert page.has_content? "Hector Huertas"
        assert page.has_content? "5"
        assert page.has_content? "4"
        assert page.has_content? "3"
      end
    end
  end

  test "user sees dashboard with contributions info" do
    VCR.use_cassette("apicurious") do
      visit dashboard_path

      assert page.has_content? "Last year: "
      assert page.has_content? "Longest streak: 21"
      assert page.has_content? "Current streak: 4"
    end
  end

  test "user sees dashboard with commit history" do
    VCR.use_cassette("apicurious") do
      visit dashboard_path

      assert page.has_content? "Commits"
      assert page.has_content? "Pushed 30 commits to hectorhuertas/apicurious"
    end
  end

  test "user sees dashboard with repositories" do
    VCR.use_cassette("apicurious") do
      visit dashboard_path

      assert page.has_content? ".dotfiles"
      assert page.has_content? "apicurious"
      assert page.has_content? "binary_search_tree"
      assert page.has_content? "clarke_coin"
      assert page.has_content? "complete_me"
    end
  end
end
