Rails.application.routes.draw do

  get '/status', to: 'status#index'
  get '/priorities', to: 'priorities#index'
  get '/members', to: 'members#index'

  resources :tasks
  match '/tasks/:id/move', to: 'tasks#move', via: :post
  match '/tasks/:id/transfer', to: 'tasks#transfer', via: :post

end
