Rails.application.routes.draw do

  resources :reports do
    get 'chart' => 'reports#chart'
  end

  root 'fetches#new'

  resources :fetches
  resources :events
end
