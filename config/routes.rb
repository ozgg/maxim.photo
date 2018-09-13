Rails.application.routes.draw do
  resources :albums, :photos, only: %i[update destroy]

  scope '(:locale)', constraints: { locale: /ru|en/ } do
    root 'index#index'

    resources :albums, :photos, only: %i[new create edit]

    namespace :admin do
      resources :albums, only: %i[index show] do
        member do
          get 'photos'
          post 'toggle', defaults: { format: :json }
          post 'priority', defaults: { format: :json }
        end
      end
      resources :photos, only: :show do
        member do
          post 'toggle', defaults: { format: :json }
          post 'priority', defaults: { format: :json }
        end
      end
    end
  end
end
