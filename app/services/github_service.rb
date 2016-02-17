class GithubService
  attr_reader :conn

  def initialize(current_user)
    @conn = Faraday.new(url: 'https://api.github.com')
    conn.headers = {
      'Accept' => 'application/vnd.github.v3+json',
      'Authorization'=>"token #{current_user.token}" }
  end

  def user
    @conn.get("/user")
  end
end
