Rails.application.routes.draw do
  # get 'users/index'
  get '/users', to: 'users#index'

  get '/users/:id', to: 'users#show'

  post '/users', to: 'users#create'

  delete '/users/:id', to: 'users#destroy'
end
