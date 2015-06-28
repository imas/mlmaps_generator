Rails.application.routes.draw do
  root to: 'home#index'

  # auth
  get '/auth/:provider/callback', :to => 'sessions#callback'
  post '/auth/:provider/callback', :to => 'sessions#callback'
  get '/logout' => 'sessions#destroy', :as => :logout

  # twitter
  get 'twitter/friends'
end
