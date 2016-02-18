require 'open-uri'
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
    JSON.parse(@conn.get("/users/#{user['login']}/starred").body).count
  end

  def contributions
    doc = Nokogiri::HTML(open("https://github.com/hectorhuertas"))
    total = doc.xpath('//*[@id="contributions-calendar"]/div[3]/span[2]')
            .text.split.first
    longest = doc.xpath('//*[@id="contributions-calendar"]/div[4]/span[2]')
            .text.split.first
    current = doc.xpath('//*[@id="contributions-calendar"]/div[5]/span[2]')
            .text.split.first
    {
      total: total,
      longest: longest,
      current: current
    }
  end

  def commit_history
    events = JSON.parse(conn.get("/users/hectorhuertas/events").body, symbolize_names: true)
    pushes = []
    events.each do |event|
      if event[:type]=="PushEvent"
        pushes << event
      end
    end
    commits = pushes.map do |push|
      {
        total: push[:payload][:commits].size,
        repo: push[:repo][:name]
      }
    end.take(5)
  end
end
