Rails.application.routes.draw do
  root to: 'twmaps#show', id: 'millifes2'

  # auth
  get '/auth/:provider/callback', :to => 'sessions#callback'
  post '/auth/:provider/callback', :to => 'sessions#callback'
  get '/logout' => 'sessions#destroy', :as => :logout

  resources :twmaps, only: [:show]
end
