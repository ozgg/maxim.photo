Rails.application.routes.draw do
  root 'index#index'

  resources :photos

  get 'about' => 'index#about'

  controller :authentication do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
end
