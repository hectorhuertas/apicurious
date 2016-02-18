class GithubService
  attr_reader :conn, :user

  def initialize(user)
    @user = user
    @conn = Faraday.new(url: 'https://api.github.com')
    conn.headers = {
      'Accept' => 'application/vnd.github.v3+json',
      'Authorization'=>"token #{user.token}" }
  end

  def user
    JSON.parse(@conn.get("/user").body)
  end

  def starred
    # binding.pry
    JSON.parse(@conn.get("/users/#{user['login']}/starred").body).count
  end
end
