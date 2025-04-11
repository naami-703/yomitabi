Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  #会員側設定
  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  root to:"public/homes#top"
  get 'about', to: 'public/homes#about'
  
  scope module: 'public' do
    resources :users, only:[:index, :show, :edit, :update, :destroy] do
      collection do
        get 'mypage'
      end
    end
    resources :books do
      collection do
        get 'search'
      end
      resources :comments, controller: 'books/comments',only:[:index, :create, :destroy]
      resource :bookmarks, only:[:create, :destroy]
    end
    resources :spots do
      resources :comments,  controller: 'spots/comments', only:[:index, :create, :destroy]
      resource :went, only:[:create, :destroy]
      resource :want_to_gos, only:[:create, :destroy]
    end
    resources :genres, only: [:show]
    resources :locations, only: [:show]
    resources :post_managements, only: [:show, :create, :update, :destroy]
    resource :relations, only: [:create, :destroy]
    resources :notifications, only: [:update]
    get 'searches', to: 'searches#index'
  end

  #管理者側設定
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  get "/admin", to: "admin/homes#top", as: "admin/top"
  get 'admin/searches', to: 'admin/searches#index', as: "admin/searches"

  namespace :admin do
    resources :books, only: [:index, :edit, :update, :destroy]
    resources :spots, only: [:index, :edit, :update, :destroy]
    resources :locations, only: [:index, :create,:edit, :update, :destroy]
    resources :genres, only: [:index, :create]
    resources :users, only: [:index, :edit, :update, :destroy]
    resources :comments, only:[:index, :destroy]
  end

end
