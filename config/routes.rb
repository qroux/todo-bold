Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :lists, only: [:show, :index, :create, :destroy] do
  end

  resources :tasks, only: [:create, :update] do
    member do
      patch 'done'
      patch 'undo'
    end
  end
end
