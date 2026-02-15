Rails.application.routes.draw do
  root "home#top"

  get    "login",  to: "sessions#new"
  post   "login",  to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :customers

  resources :cars do
    resources :repairs, shallow: true
  end

  resources :repairs, only: [:index]

  resources :loaner_cars, only: [:index, :new, :create] do
    resources :rentals, only: [:index]
  end

  resources :rentals, only: [:new, :create]
end
