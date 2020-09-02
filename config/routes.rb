Rails.application.routes.draw do
  root to: 'tasks#index'
  #root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
    get 'signup', to: 'users#new'
    resources :toppages, only: [:index]
    resources :users, only: [:index, :show, :new, :create]
    resources :tasks
     #resources :tasks, only: [:create, :destroy, ]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
