Rails.application.routes.draw do
  namespace :v1 do
    resources :user, only:[:index, :create, :update, :destroy]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
