Rails.application.routes.draw do
  root 'index#index'

  resources :albums, :photos

  namespace :admin do
    resources :albums, only: [:index, :show] do
      member do
        post 'priority', defaults: { format: :json }
        post 'toggle', defaults: { format: :json }
      end
    end

    resources :photos, only: [:index, :show] do
      member do
        post 'priority', defaults: { format: :json }
        post 'toggle', defaults: { format: :json }
      end
    end
  end
end
