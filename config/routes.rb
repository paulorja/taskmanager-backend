Rails.application.routes.draw do

  get '/status', to: 'status#index'
  get '/priorities', to: 'priorities#index'
  get '/members', to: 'members#index'

  resources :tasks

end
