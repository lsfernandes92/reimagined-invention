# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :auths, only: [:create]

  resources :kinds

  api_version(:module => "V1", :parameter => {:name => "version", :value => "1"}) do
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

  api_version(:module => "V2", :parameter => {:name => "version", :value => "2"}) do
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
