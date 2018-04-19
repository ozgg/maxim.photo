Rails.application.routes.draw do
  scope '(:locale)', constraints: { locale: /ru|en/ } do
    root 'index#index'

    resources :albums, :photos, only: [:new, :create, :edit]

    namespace :admin do
      resources :albums, :photos, only: [:index, :show] do
        member do
          post 'toggle', defaults: { format: :json }
          post 'priority', defaults: { format: :json }
        end
      end
    end
  end

  resources :albums, :photos, only: [:update, :destroy]
end
