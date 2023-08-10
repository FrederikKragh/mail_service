Rails.application.routes.draw do
  root "statistics#index"
  
  get :callback, to: "emails#callback"
  resources :emails, only: %i[new index show] 
end
