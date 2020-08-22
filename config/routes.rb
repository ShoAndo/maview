Rails.application.routes.draw do
  devise_for :companies, controllers: {
    sessions:      'companies/sessions',
    registrations: 'companies/registrations'
  }
  devise_for :creators, controllers: {
    sessions:      'creators/sessions',
    registrations: 'creators/registrations'
  }
  root 'orders#index'
  resources :creators, only: [:index, :edit, :show, :update] do
    resources :careers, only: [:new, :create, :edit, :update]
    resources :introductions, only: [:new, :create, :edit, :update]
    resources :portforios, only: [:new, :create, :edit, :update]
    resources :skills, only: [:new, :create, :edit, :update]
  end
  resources :companies, only: [:index, :show, :update]
  resources :rooms, only: :index
  resources :orders do
    resources :rooms, only: [:new, :create, :destroy] do
      resources :payments, only: [:index, :create]
      resources :messages, only: [:index, :create]
    end
  end
end
