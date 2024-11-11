Rails.application.routes.draw do
  mount Sidekiq::Web => '/job-monitor'

  get  "sign-up",  to: "pages#sign_up"
  get  "sign-in",  to: "pages#sign_in"
  post "sign-up",  to: "sessions#sign_up"
  post "sign-in",  to: "sessions#sign_in"
  delete "logout", to: "sessions#destroy"

  resources :tasks

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
