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
    doc = Nokogiri::HTML(open("https://github.com/#{user['login']}"))
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
    events = JSON.parse(conn.get("/users/#{user['login']}/events").body, symbolize_names: true)
    pushes = []
    events.each do |event|
      if event[:type]=="PushEvent"
        pushes << event
      end
    end
    last = pushes.select do |push|
      limit = Date.today - 7
      Date.parse(push[:created_at]) > limit
    end
    repos = last.map{|event| event[:repo][:name]}.uniq
    # binding.pry
    commits = pushes.map do |push|
      {
        total: push[:payload][:commits].size,
        repo: push[:repo][:name]
      }
    end.take(5)
  end

  def commits(period = :week)
    repos = JSON.parse(conn.get("/users/#{user['login']}/repos?sort=pushed").body, symbolize_names: true)

    filtered = repos.select do |repo|
      Date.parse(repo[:pushed_at]) > (Date.today - filter[period])
    end

    names = filtered.map{|repo| repo[:name]}

    names.map do |repo|
      repo_commits(repo)
    end
  end

  def repo_commits(repo)
    ## Use pagination to get all of them for real
    raw_commits = JSON.parse(conn.get("/repos/#{user['login']}/#{repo}/commits").body, symbolize_names: true)
    # commits2 = JSON.parse(conn.get("/repos/#{user['login']}/#{repo}/commits?since=2013-02-18").body, symbolize_names: true)
    commits = raw_commits.map do |commit|
      {
        short_sha: commit[:sha].slice(0,7),
        date: Time.parse(commit[:commit][:author][:date]),
        message: commit[:commit][:message],
        url: commit[:html_url]
      }
    end
    {
      repo: "#{user['login']}/#{repo}",
      total: commits.count,
      commits: commits
    }
    # binding.pry
  end

  def filter
    {
      week: 7,
      month: 30
    }
  end

  def repos
    repos = JSON.parse(conn.get("/users/#{user['login']}/repos").body, symbolize_names: true)
    repos.map do |repo|
      {
        name: repo[:name],
        url: repo[:html_url]
      }
    end.take(5)
  end
end
