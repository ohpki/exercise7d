Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root :to => 'homes#top'
  get "home/about" => "homes#about"
  resources :users, only: [:index,:show,:edit,:update] do
    member do
    get :follows, :followers
  end
  resource :relationships, only: [:create, :destroy]
  end
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]

  end
  get 'book/search' => 'books#search'
  get "search" => "searches#search"
  get "search_tag"=>"books#search_tag"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
