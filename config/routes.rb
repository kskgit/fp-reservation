Rails.application.routes.draw do
  namespace :customer do
    root 'top#index'
  end

  namespace :fp do
    root 'top#index'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
