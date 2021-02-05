Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  get 'searches' => 'searches#search'
  resources :users,only: [:show,:index,:edit,:update] do
    member do
      get "follower"
      get "followed"
    end
  end
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  post 'follow/:id' => 'relationships#follow', as: 'follow'
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
  # get 'follower' => 'users#follower', as: 'follower'
  # get 'followed' => 'users#followed', as: 'followed'
  # resources :relationships, only: [:create, :destroy]
  # resources :searches, only: [:index]
  

end