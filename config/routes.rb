Rails.application.routes.draw do
  root 'about#home'
  resources :people
end
