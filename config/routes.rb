Rails.application.routes.draw do
  root 'pages#login'

  get "/auth/:provider/callback", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  get "/dashboard", to: "pages#dashboard"
  get "/supertest", to: "pages#supertest"
end
