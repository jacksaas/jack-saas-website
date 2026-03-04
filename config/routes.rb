Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  # Root path
  root "home#index"

  # Static pages
  get "/services", to: "pages#services"
  get "/process", to: "pages#workflow_process"
  get "/case-studies", to: "pages#case_studies"
  get "/about", to: "pages#about"
  get "/quote", to: "pages#quote"

  # API routes
  namespace :api do
    post "quote", to: "quotes#create"
  end
end
