Rails.application.routes.draw do
  devise_for :users
  devise_for :admins

  root 'events#index'

  resources :events

  namespace :admin do
    root 'events#index'
    resources :events
  end
end
