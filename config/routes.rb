Rails.application.routes.draw do
  get 'sessions/new'
  # remember to rename both sessions/new and sessions to something more convenient, like /login later...
  post 'sessions', to: 'sessions#create'
  resources :users
  get 'welcome/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'users#index'
end
