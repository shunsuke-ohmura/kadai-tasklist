Rails.application.routes.draw do
    root to: 'tasks#index'
    
    get 'signup', to: 'users#new'
    resources :toppages, only: [:index]
    resources :users, only: [:index, :show, :new, :create]
    resources :tasks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
