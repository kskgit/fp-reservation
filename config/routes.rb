Rails.application.routes.draw do
  namespace :customer do
    root 'top#index'
    get 'login' => 'sessions#new', as: :login
    resource :session, only: %i[create destroy]
  end

  namespace :fp do
    root 'top#index'
    get 'login' => 'sessions#new', as: :login
    resource :session, only: %i[create destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
