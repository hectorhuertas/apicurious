class GithubService
  attr_reader :conn

  def initialize(current_user)
    @conn = Faraday.new(url: 'https://api.github.com')
  end

  def user
    @conn.get("/user", {}, {'Authorization'=>"token #{current_user.token}"})
  end
end
