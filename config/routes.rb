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

  scope module: :public do
    root to: "cars#index"

    get "customer/mypage", to: "customers#mypage", as:"mypage"
    get "customer/information", to: "customers#edit", as:"information"
    patch "customers/information", to: "customers#update", as:"information_update"
    get "customers/confirm_withdraw", to: "customers#confirm_withdraw", as:"confirm_withdraw"
    patch "customers/withdraw", to: "customers#withdraw", as:"withdraw"

    get "appointments/buy_and_sell", to: "appointments#buy_and_sell", as: "new_buy_and_sell"
    post "appointments/buy_and_sell", to: "appointments#create", as: "buy_and_sell"

    resources :enquiries, only: [:new, :create, :show]
    resources :buy_requests, only: [:new, :create]
    resources :sell_requests, only: [:new, :create]
    resources :appointments, only: [:index, :create, :show]

    resources :cars, only: [:show]

  end

  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :subgenres, only: [:create, :update]
    resources :cars, only: [:create, :index, :new, :show, :edit, :update, :destroy]
  end


end