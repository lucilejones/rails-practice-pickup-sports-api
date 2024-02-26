Rails.application.routes.draw do
  resources :events
  resources :posts
  resources :users do
    get 'posts', to: 'users#posts_index'
  end
end
