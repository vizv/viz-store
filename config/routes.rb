Rails.application.routes.draw do
  devise_for :users, only: [:sessions]

  namespace :manage do
    resources :buckets do
      resources :resources
    end
  end

  root 'application#index'
  match '/:bucket/*path' => 'application#resource', via: :get
end
