Rails.application.routes.draw do

  root 'feed#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }


  resources :feed
  resources :profile
  resources :photos
  resources :albums
  resources :info_profile
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  as :user do
    get 'users' => "devise/registrations#new"
    get "signin" => "devise/sessions#new"
    post "signin" => "devise/sessions#create"
    delete "signout" => "devise/sessions#destroy"
  end

  delete'/controller/remove_image/:id' => 'controller#remove_image', as: :remove_image


  post 'follow', to: "info_profile#follow"
  post 'unfollow', to: "info_profile#unfollow"
end
