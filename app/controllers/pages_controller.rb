class PagesController < ApplicationController
  def login
    redirect_to :dashboard if current_user
  end

  def dashboard
    git = GithubService.new(current_user)
    @user = git.user
    @starred = git.starred
    @contributions = git.contributions
    @commit_history = git.commit_history
    @repos = git.repos
    @commits = git.commits
    # @user = {'followers'=> 5, 'following'=>8}
    # @starred = 9
    # @contributions = {
    #   total: 429,
    #   longest: 23,
    #   current: 7
    # }
    # @commits = [ {:repo=>"hectorhuertas/apicurious",
    #   :total=>30,
    #   :commits=>
    #   [{:short_sha=>"233f12d",
    #     :message=>"Merge pull request #22 from hectorhuertas/simple_cov\n\nSetup simplecov",
    #     :url=>"https://github.com/hectorhuertas/apicurious/commit/233f12dd310e979a4fe73c8cf96df8e90f80c9c1"},
    #     {:short_sha=>"52558b2",
    #       :message=>"Add navbar",
    #       :url=>"https://github.com/hectorhuertas/apicurious/commit/52558b2c29d1b28b3cb9bce9900dc85fcb0e3492"}
    #       ]}]
    # @commit_history = [{:total=>3, :repo=>"hectorhuertas/apicurious"},
    #                    {:total=>2, :repo=>"hectorhuertas/apicurious"},
    #                    {:total=>2, :repo=>"hectorhuertas/apicurious"},
    #                    {:total=>2, :repo=>"hectorhuertas/apicurious"},
    #                    {:total=>3, :repo=>"hectorhuertas/apicurious"}]
    # @repos = [{:name=>".dotfiles", :url=>"https://github.com/hectorhuertas/.dotfiles"},
    #           {:name=>"apicurious", :url=>"https://github.com/hectorhuertas/apicurious"},
    #           {:name=>"binary_search_tree", :url=>"https://github.com/hectorhuertas/binary_search_tree"},
    #           {:name=>"clarke_coin", :url=>"https://github.com/hectorhuertas/clarke_coin"},
    #           {:name=>"complete_me", :url=>"https://github.com/hectorhuertas/complete_me"}]
  end
end
