Rails.application.routes.draw do
  resources :buckets
  resources :resources
  devise_for :users, only: [:sessions]

  root 'application#index'
  match '/:bucket/*path' => 'application#resource', via: :get
end
