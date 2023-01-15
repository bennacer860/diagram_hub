Rails.application.routes.draw do
  root 'diagrams#index'
  resources :diagrams
end
