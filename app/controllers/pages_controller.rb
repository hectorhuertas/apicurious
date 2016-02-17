class PagesController < ApplicationController
  def login
    redirect_to :dashboard if current_user
  end

  def dashboard
  end

  def supertest
  end
end
