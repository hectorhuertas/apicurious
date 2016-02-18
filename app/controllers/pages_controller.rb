class PagesController < ApplicationController
  def login
    redirect_to :dashboard if current_user
  end

  def dashboard
    git = GithubService.new(current_user)
    # @user = git.user
    @user = {'followers'=> 5, 'following'=>8}
    # @starred = git.starred
    @starred = 9
    # @contributions = git.contributions
    @contributions = {}
    # @commit_history = git.commit_history
    @commit_history = {}
    # @repos = git.repos
    @repos = {}
  end
end
