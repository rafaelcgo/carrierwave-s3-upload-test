Platafotto::Application.routes.draw do
  devise_for :users

  namespace :api do
    resources :events, only: [:create, :index, :show]
    resources :photos, only: [:create, :index]
    resources :users,  only: [:create, :index]
  end

  resources :events

  controller :static do
    get 'home'
    get 'terms'
  end

  root 'static#home'
end
