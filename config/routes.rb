Rails.application.routes.draw do
  # topページ
  root 'homes#top'

  # 説明ページ
  get 'about' => 'homes#about'

  # ログイン機能
  devise_for :users, skip: :all
  devise_scope :user do
    get 'login' => 'devise/sessions#new', as: :new_user_session
    post 'login' => 'devise/sessions#create', as: :user_session
    delete 'logout' => 'devise/sessions#destroy', as: :destroy_user_session
    get 'signup' => 'devise/registrations#new', as: :new_user_registration
    post 'signup' => 'devise/registrations#create', as: :user_registration
  end

  # マイページ
  get 'mypage' => 'users#mypage'
  # get 'mypage/edit' => 'users#edit'
  get 'mypage/alert' => 'users#alert'
  patch 'withdraw' => 'users#withdraw'

  # プロフィール
  resources :profiles do
    member do
      get :timeline
    end
  end

  # タイムライン
  resources :posts, except: [:new, :show]
end
