Rails.application.routes.draw do
  root "emails#index"
  
  get :callback, to: "google#callback"
  resources :emails, only: %i[index show] 
  resources :google, only: %i[new], path: "google"
end
