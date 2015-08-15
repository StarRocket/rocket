Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'

  devise_for :users
  
  resources :posts do
  	resources :comments
  end
end
