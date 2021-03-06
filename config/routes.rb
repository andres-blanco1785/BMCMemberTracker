# frozen_string_literal: true

Rails.application.routes.draw do
  root 'members#index'
  # root to: 'dashboards#show'
  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end
  resources :payments
  resources :officers
  resources :members
  resources :withdrawals
  resources :deposits
  resources :payment_methods
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # The finances page does not have model, it is an extra page... would be similar for tutorial/documentation
  get 'finances', to: 'finances#index'
end
