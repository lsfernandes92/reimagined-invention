# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :auths, only: [:create]

  resources :kinds

  constraints subdomain: 'v1' do
    scope module: 'v1' do
      resources :contacts do
        resource :kind, only: [:show]
        resource :kind, only: [:show], path: 'relationships/kind'
    
        resource :phones, only: [:show]
        resource :phones, only: [:show], path: 'relationships/phones'
    
        resource :phone, only: [:update, :create, :destroy]
        resource :phone, only: [:update, :create, :destroy], path: 'relationships/phone' 
    
        resource :address, only: [:show, :update, :create, :destroy]
        resource :address, only: [:show, :update, :create, :destroy], path: 'relationships/address'
      end
    end
  end

  constraints subdomain: 'v2' do
    scope module: 'v2' do
      resources :contacts do
        resource :kind, only: [:show]
        resource :kind, only: [:show], path: 'relationships/kind'
    
        resource :phones, only: [:show]
        resource :phones, only: [:show], path: 'relationships/phones'
    
        resource :phone, only: [:update, :create, :destroy]
        resource :phone, only: [:update, :create, :destroy], path: 'relationships/phone'
    
        resource :address, only: [:show, :update, :create, :destroy]
        resource :address, only: [:show, :update, :create, :destroy], path: 'relationships/address'
      end
    end
  end
end
