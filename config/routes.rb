Rails.application.routes.draw do

  root "pages#index"

  resources :pages
  resources :users
  resources :games
  
  get '/sign-up' => 'registrations#new', as: :signup
  post '/sign-up' => 'registrations#create'
end
