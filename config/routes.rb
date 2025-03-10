Rails.application.routes.draw do

  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  root to:"public/homes#top"
  get 'about', to: 'public/homes#about'

  resources :users, controller: 'public/users', only:[:index, :show, :edit, :update, :destroy] do
    collection do
      get 'mypage'
    end
  end

  resources :books, controller: 'public/books' do
    resources:comments, controller: 'public/books/comments', only:[:create, :destroy]
    resource:bookmarks, controller: 'public/books/bookmarks', only:[:create, :destroy]
  end

  resources :spots, controller: 'public/spots' do
    resources:comments, controller: 'public/spots/comments', only:[:create, :destroy]
    resource:went, controller: 'public/spots/wents',only:[:create, :destroy]
    resource:want_to_gos, controller: 'public/spots/want_to_gos', only:[:create, :destroy]
  end  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
