Rails.application.routes.draw do
  devise_for :users
  root 'diagrams#index'
  resources :diagrams
end
