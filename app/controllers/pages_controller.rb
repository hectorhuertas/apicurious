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
    @repos = [{:name=>".dotfiles", :url=>"https://github.com/hectorhuertas/.dotfiles"},
              {:name=>"apicurious", :url=>"https://github.com/hectorhuertas/apicurious"},
              {:name=>"binary_search_tree", :url=>"https://github.com/hectorhuertas/binary_search_tree"},
              {:name=>"clarke_coin", :url=>"https://github.com/hectorhuertas/clarke_coin"},
              {:name=>"complete_me", :url=>"https://github.com/hectorhuertas/complete_me"}]
  end
end
