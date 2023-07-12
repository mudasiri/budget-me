Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions/sessions',
    registrations: 'users/sessions/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "home#index"

  resources :categories, except: [:update, :edit] do
    resources :payments, except: [:update, :edit]
  end
end
