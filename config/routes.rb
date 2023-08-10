Rails.application.routes.draw do
  root "statistics#index"
  
  get '/new', to: 'emails#new'
  get '/emails', to: 'emails#index'
  get '/callback', to: 'emails#callback'
end
