Rails.application.routes.draw do
  root 'index#index'

  mount Track::Engine, at: '/'

  resources :photos

  get 'about' => 'index#about'

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
