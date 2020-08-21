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
  resources :creators, only: [:show, :update]
  resources :companies, only: [:show, :update]
  resources :orders do
    resources :rooms, only: [:index, :new, :create, :destroy] do
      resources :messages, onlu: [:index, :create]
    end
  end
end
