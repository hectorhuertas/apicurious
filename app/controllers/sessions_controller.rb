class SessionsController < ApplicationController
  def create
    # binding.pry
    redirect_to dashboard_path
  end
end
