Rails.application.routes.draw do
  root 'index#index'

  scope 'portfolio', controller: :portfolio do
    get '/' => :index, as: :portfolio
    get '/:theme' => :theme, as: :portfolio_theme
    get '/:theme/:album' => :album, as: :portfolio_album
    get '/:theme/:album/:id' => :photo, as: :portfolio_photo
  end

  resources :themes, :albums, :photos, :tags, :illustrations

  resources :posts do
    collection do
      get 'tagged/:tag_name' => :tagged, as: :tagged
    end
  end

  controller :index do
    get 'about'
  end

  controller :administration do
    get 'administration' => :index, as: :admin
  end

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
end
