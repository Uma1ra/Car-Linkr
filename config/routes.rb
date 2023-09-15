Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  devise_scope :customer do
    root to: "public/sessions#new"
    post "sessions/guest_login", to: "public/sessions#guest_login", as: "guest_login"
  end

  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :subgenres, only: [:create, :update]

    resources :cars, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  end

  scope module: :public do
    get "customer/mypage" => "customers#mypage", as:"mypage"
  end

end
