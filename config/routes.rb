Rails.application.routes.draw do


  devise_for :members,skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }


  scope module: :user do
    get root to: 'homes#top',as: 'root'
    get 'about' => 'homes#about',as: 'about'
    get 'posts/question' => 'posts#question',as: 'question'
    resources :posts, only:[:index,:new,:create,:show,:edit,:update,:destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    get 'members/check' =>  'members#check', as: 'check'
    patch 'members/withdrawal' => 'members#withdrawal', as: 'withdrawal'
    resources :members, only:[:index,:show,:edit,:update]
  end


  namespace :admin do
    resources :members, only:[:index,:show,:edit,:update]
    resources :posts, only:[:index,:show,:edit,:update,:destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
