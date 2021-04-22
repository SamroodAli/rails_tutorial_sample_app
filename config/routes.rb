# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#home'
  get '/signup',  to: 'users#new'
  get '/help',    to: 'static_pages#help'
  get '/about',   to:  'static_pages#about'
  get '/contact', to:  'static_pages#contact'
  get '/users' ,to: 'users#new'
  resources :users
end
