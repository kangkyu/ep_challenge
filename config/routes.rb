Rails.application.routes.draw do

  resources :reports

  root 'fetches#new'

  resources :fetches
  resources :events
end
