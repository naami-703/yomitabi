Rails.application.routes.draw do

  devise_for :users

  root to:"homes#top"
  get 'homes/about', as:'about'

  resources :users, only:[:show, :edit, :update, :destroy] do
    member do
      get 'mypage'
    end
  end

  resources :books do
    resources:comments, controller: 'books/comments', only:[:create, :destroy]
    resource:bookmarks, controller: 'books/bookmarks', only:[:create, :destroy]
  end

  resources :spots do
    resources:comments, controller: 'spots/comments', only:[:create, :destroy]
    resource:went, controller: 'spots/wents',only:[:create, :destroy]
    resource:want_to_gos, controller: 'spots/want_to_gos', only:[:create, :destroy]
  end  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
