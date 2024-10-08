Rails.application.routes.draw do
  resources :tickets, only: [:show, :index]
  get '/:id', to: 'tickets#show', constraints: { id: /[0-9A-F]{8}/ }
  root to: 'tickets#index'
end
