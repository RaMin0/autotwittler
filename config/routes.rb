Rails.application.routes.draw do
  devise_for :users, path: '', controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  devise_scope :user do
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end
  
  resource :profile, only: [:show, :update]
  
  resources :users do
    collection do
      get :search
    end
    
    get :statuses
    
    post :follow, controller: :followships, action: :create
    delete :unfollow, controller: :followships, action: :destroy
    
    post :block, controller: :blocks, action: :create
    delete :unblock, controller: :blocks, action: :destroy
  end
  
  resources :statuses, only: :create do
    resources :replies, only: [:index, :create]
  end
  
  resource :timeline, controller: :timeline, only: [] do
    get :statuses
    get :recents
  end
  
  root 'timeline#show'
end
