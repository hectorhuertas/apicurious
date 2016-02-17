class PermissionService
  attr_reader :user, :controller, :action

  def initialize(user)
    # @user = user || User.new
    @user = user
  end

  def allow?(controller, action)
    @controller = controller
    @action = action

    return true if @user
    return true if controller == "pages" && action === "login"
    return true if controller == "sessions" && action === "create"
  end
end
