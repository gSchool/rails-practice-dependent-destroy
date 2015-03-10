Rails.application.routes.draw do
  root "dashboard#index"
  get "signin" => "sessions#new", as: :signin
  post "signin" => "sessions#create"
  get "signout" => "sessions#destroy", as: :signout

  resources :patients do
    resources :prescriptions
  end

  resources :medications, :only => [:show, :destroy]
end
