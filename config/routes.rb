# frozen_string_literal: true

Rails.application.routes.draw do
  concern :check do
    post :check, on: :collection, defaults: { format: :json }
  end

  concern :toggle do
    post :toggle, on: :member, defaults: { format: :json }
  end

  concern :priority do
    post :priority, on: :member, defaults: { format: :json }
  end

  get 'sitemap' => 'index#sitemap', defaults: { format: :xml }

  resources :albums, :photos, :photo_tags, :stories, only: %i[update destroy]

  scope '(:locale)', constraints: { locale: /ru|en/ } do
    root 'index#index'

    resources :albums, :stories, :photos, :photo_tags, except: %i[update destroy show], concerns: :check
    get 'albums/:id-:slug' => 'albums#show', as: :show_album
    get 'stories/:id-:slug' => 'stories#show', as: :show_story
    get 'stream' => 'photos#stream'

    namespace :admin do
      resources :albums, only: %i[index show]
      resources :stories, only: %i[index show]
      resources :photos, only: %i[index show], concerns: %i[toggle priority] do
        member do
          put 'tags/:tag_id' => :add_tag, as: :tag
          delete 'tags/:tag_id' => :remove_tag
        end
      end
      resources :photo_tags, only: %i[index show]
      resources :featured_photos, :featured_albums, only: %i[index create destroy], concerns: %i[priority toggle]
    end
  end
end
