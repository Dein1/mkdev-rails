Rails.application.routes.draw do
  devise_for :users
  devise_for :admins

  root 'events#index'

  resources :events

  namespace :admin do
    root 'events#index'

    resources :events do
      collection do
        get 'pending'
      end

      member do
        put 'approve'
      end

      member do
        put 'reject'
      end
    end
  end
end
