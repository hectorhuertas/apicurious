require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest
  test "guest login with github" do
    visit root_path
    assert_equal User.count, 0

    click_on "Login with GitHub to Start"

    assert_equal dashboard_path, current_path
    assert_equal User.count, 1





    user = User.last
    VCR.use_cassette("gittester") do
      # response = Faraday.get('http://www.iana.org/domains/reserved')
      response = GithubService.new(user).user
      # binding.pry
      # response = Net::HTTP.get_response(URI('http://www.iana.org/domains/reserved'))
    end
    # assert_match /Example domains/, response.body
    # binding.pry
    # needs mocking github login
  end

  test "user logout" do
    visit root_path
    click_on "Login with GitHub to Start"

    assert_equal dashboard_path, current_path

    click_on "Logout"
    assert_equal root_path, current_path
  end

  test "user root goes to dashboard page" do
    user = create(:user)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit root_path

    assert_equal dashboard_path, current_path
  end
end
