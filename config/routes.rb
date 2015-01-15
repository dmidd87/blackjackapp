Rails.application.routes.draw do

  root "pages#index"

  resources :pages
  resources :users

  resources :games do
    post '/hand' => 'games#show'
  end

  get '/sign-up' => 'registrations#new', as: :signup
  post '/sign-up' => 'registrations#create'

  get '/sign-in' => 'authentications#new', as: :signin
  post '/sign-in' => 'authentications#create'

  get '/sign-out' => 'authentications#destroy', as: :signout
end
