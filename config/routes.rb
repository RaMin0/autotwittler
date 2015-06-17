Rails.application.routes.draw do
  devise_for :users, path: '', controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  devise_scope :user do
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end
  
  resource :profile, except: :destroy
  
  resources :users do
    collection do
      get :search
    end
    
    post :follow, controller: :followships, action: :create
    delete :unfollow, controller: :followships, action: :destroy
    
    post :block, controller: :blocks, action: :create
    delete :unblock, controller: :blocks, action: :destroy
  end
  
  resources :statuses, only: :create do
    resources :replies, only: [:index, :create]
  end
  
  root 'timeline#index'
end
