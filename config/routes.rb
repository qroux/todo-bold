Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :lists, only: [:show, :index, :create, :destroy] do
    member do
      patch 'add_collaborator'
    end

    collection do
      get 'shared'
    end
  end

  resources :tasks, only: [:create, :update] do
    member do
      patch 'done'
      patch 'undo'
    end

    collection do
      get 'search'
    end
  end

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
