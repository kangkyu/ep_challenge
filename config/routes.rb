Rails.application.routes.draw do

  root 'fetches#new'

  resources :fetches
  # except: [:show, :edit, :update]

  resources :events
end
