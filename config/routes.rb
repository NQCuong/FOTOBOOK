Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/user', as: 'rails_admin'
  root 'feed#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }


  resources :feed

  resources :profile

  resources :photos do
    resources :votes, only: [:create, :destroy]
  end

  resources :albums do
    resources :votes, only: [:create, :destroy]
  end

  resources :info_profile


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  as :user do
    get 'users' => "devise/registrations#new"
    get "signin" => "devise/sessions#new"
    post "signin" => "devise/sessions#create"
    delete "signout" => "devise/sessions#destroy"
  end

  post 'follow', to: "info_profile#follow"
  post 'unfollow', to: "info_profile#unfollow"


  post "like/photo/:id_photo", to: "index#like_photo", as: "like/photo"
  post "like/album/:id_album", to: "index#like_album", as: "like/album"

end