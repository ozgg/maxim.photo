Rails.application.routes.draw do
  root 'index#index'

  mount Track::Engine, at: '/'

  get 'about' => 'index#about'

  resources :photos

  controller :authentication do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  namespace :admin do
    get '/' => 'index#index'

    resources :photos, only: [:index, :show]
  end
end
