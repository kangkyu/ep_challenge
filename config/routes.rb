Rails.application.routes.draw do

  root 'fetches#new'

  resources :fetches
  resources :events
end
