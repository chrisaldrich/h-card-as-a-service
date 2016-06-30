Rails.application.routes.draw do
  root 'about#home'

  # /new person
  get '/new', to: 'people#new', as: 'new'

  # subdomain routes
  get    '/:subdomain.:domain.:tld',      to: 'people#show'
  get    '/:subdomain.:domain.:tld/edit', to: 'people#edit'
  patch  '/:subdomain.:domain.:tld',      to: 'people#update'
  put    '/:subdomain.:domain.:tld',      to: 'people#update'
  delete '/:subdomain.:domain.:tld',      to: 'people#destroy'

  # domain routes
  get    '/:domain.:tld',      to: 'people#show'
  get    '/:domain.:tld/edit', to: 'people#edit'
  patch  '/:domain.:tld',      to: 'people#update'
  put    '/:domain.:tld',      to: 'people#update'
  delete '/:domain.:tld',      to: 'people#destroy'

  resources :people, only: [:index, :create]

  get '/@:nickname',        to: 'nicknames#show',  as: 'nickname'
  get '/chat-people',       to: 'nicknames#index', as: 'chat_people'
end
