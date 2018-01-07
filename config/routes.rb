Chat::Engine.routes.draw do

  #root 'home#index'

  #вход
  get '/operator_signin',  to: 'sessions#new'
  #выход
  delete '/operator_signout', to: 'sessions#destroy'

  resources :sessions, only: [:new, :create, :destroy]
  resources :operators
  resources :users

  #регистрация
  get '/operator_signup',  to: 'users#new'

  resources :dialogs
  resources :quick_phrases
  resources :quick_groups

  resources :conversations do
    member do
      post :close
    end
  end

end
