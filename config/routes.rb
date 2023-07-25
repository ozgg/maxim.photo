Rails.application.routes.draw do
  root "index#index"

  # Users component
  controller :authentication do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
end
