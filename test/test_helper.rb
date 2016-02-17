ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "mocha/mini_test"
require "capybara/rails"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...
  # include FactoryGirl::Syntax::Methods

end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include FactoryGirl::Syntax::Methods

  def teardown
    reset_session!
  end
end

DatabaseCleaner.strategy = :transaction

class Minitest::Spec
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end

OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
  "provider"=>"github",
  "uid"=>"13817763",
  "info"=>
    {"nickname"=>"hectorhuertas",
     "email"=>nil,
     "name"=>"Hector Huertas",
     "image"=>"https://avatars.githubusercontent.com/u/13817763?v=3",
     "urls"=>{"GitHub"=>"https://github.com/hectorhuertas", "Blog"=>nil}},
  "credentials"=>{"token"=>ENV['GITHUB_TOKEN'], "expires"=>false}
  })
