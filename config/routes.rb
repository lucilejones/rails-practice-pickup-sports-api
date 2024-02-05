Rails.application.routes.draw do
  # get 'users/index'
  # get '/users', to: 'users#index'

  # get '/users/:id', to: 'users#show'

  # post '/users', to: 'users#create'

  # delete '/users/:id', to: 'users#destroy'


  # resources :users

  # get '/users/:id/posts', to: 'users#posts_index'


  resources :users do
    get 'posts', to: 'users#posts_index'
  end

  resources :posts, only: [:create, :update, :destroy]
end
