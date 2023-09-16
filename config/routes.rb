Rails.application.routes.draw do
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  devise_scope :customer do
    post "sessions/guest_login", to: "public/sessions#guest_login", as: "guest_login"
  end

  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :subgenres, only: [:create, :update]

    resources :cars, only: [:create, :index, :new, :show, :edit, :update, :destroy]
  end

  scope module: :public do
    root to: "cars#index"
    
    get "customer/mypage" => "customers#mypage", as:"mypage"
    
    get "customer/information" => "customers#edit", as:"information"
    patch "customers/information" => "customers#update", as:"information_update"
    
    get "customers/confirm_withdraw" => "customers#confirm_withdraw", as:"confirm_withdraw"
    patch "customers/withdraw" => "customers#withdraw", as:"withdraw"
    
    resources :cars, only: [:show]
    
  end

end