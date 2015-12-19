Rails.application.routes.draw do
  resources :comments, only: [:index, :show, :create]
  root 'comments#index'
end
