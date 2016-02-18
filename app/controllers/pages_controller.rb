class PagesController < ApplicationController
  def login
    redirect_to :dashboard if current_user
  end

  def dashboard
    git = GithubService.new(current_user)
    @user = git.user
    @starred = git.starred
    # binding.pry
  end

  def supertest
  end
end
