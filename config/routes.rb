Rails.application.routes.draw do
  root to: 'home#index'
  get '/auth/:provider/callback', :to => 'sessions#callback'
  post '/auth/:provider/callback', :to => 'sessions#callback'
  get '/logout' => 'sessions#destroy', :as => :logout
end
