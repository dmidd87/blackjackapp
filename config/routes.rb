Rails.application.routes.draw do

  root "pages#index"

  resources :pages
  resources :users
  resources :registrations
end
