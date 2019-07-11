Rails.application.routes.draw do
  get 'photos/new'
  get 'profile/index'
  get 'feed/index'
  root 'feed#index'



  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }

  resources :feed
  resources :profile
  resources :photos
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  as :user do
    get "signin" => "devise/sessions#new"
    post "signin" => "devise/sessions#create"
    delete "signout" => "devise/sessions#destroy"
  end
end
