Rails.application.routes.draw do
  root 'index#index'

  mount Biovision::Base::Engine, at: '/'

  get 'about' => 'index#about'

  resources :photos

  namespace :admin do
    get '/' => 'index#index'

    resources :photos, only: [:index, :show]
  end
end
