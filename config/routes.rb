Rails.application.routes.draw do

  devise_for :members,skip: [:passwords], controllers: {
    registrations: 'user/registrations',
    sessions: 'user/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_scope :member do
    post 'guest_sign_in', to: 'user/sessions#guest_sign_in'
  end

  scope module: :user do
    get root to: 'homes#top',as: 'root'
    get 'about' => 'homes#about',as: 'about'
    get 'search' => 'searches#search', as: 'search'
    get 'sort' => 'posts#sort', as: 'sort'
    resources :posts, only:[:index,:new,:create,:show,:edit,:update,:destroy] do
      resources :post_comments, only:[:create,:destroy]
      resource :likes, only: [:create,:destroy]
      collection do
        get 'confirm'
      end
    end
    resources :tags, only:[:posts] do
      get 'posts'  => 'posts#search_tag'
    end
    get 'members/check' =>  'members#check', as: 'check'
    patch 'members/withdrawal' => 'members#withdrawal', as: 'withdrawal'
    get 'members/:id/likes' => 'members#likes',as: 'likes_member'
    resources :members, only:[:index,:show,:edit,:update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
  end

  get 'admin/search' => 'user/searches#search', as: 'admin_search'
  namespace :admin do
    resources :members, only:[:index,:show,:edit,:update]
    resources :posts, only:[:index,:show,:edit,:update,:destroy] do
      resources :post_comments, only:[:destroy]
    end
    resources :tags, only:[:index,:destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
