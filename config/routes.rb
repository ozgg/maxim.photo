Rails.application.routes.draw do
  root 'index#index'

  resources :photos

  get 'about' => 'index#about'
end
