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
  end
  
  namespace :admin do
    resources :cars, only: [:index]
  end

  scope module: :public do
    get "customer/mypage" => "customers#mypage", as:"mypage"
  end

end
