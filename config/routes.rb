Rails.application.routes.draw do
  get '/:locale' => 'index#index', constraints: { locale: /ru|en/ }

  root 'index#index'

  scope '(:locale)', locale: /ru|en/ do
    controller :index do
      get 'about' => :about
    end

    controller :sessions do
      get 'login' => :new
      post 'login' => :create
      delete 'logout' => :destroy
    end
  end
end
