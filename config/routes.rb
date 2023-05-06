Rails.application.routes.draw do
  devise_for :users
  root 'diagrams#index'
  resources :diagrams

  #tags routes
  get '/tagged', to: "diagrams#tagged", as: :tagged
  get 'tags/ :tag' , to:  'diagrams#index', as: :tag
end
