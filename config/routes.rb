# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root to: 'pages#home'
  
  devise_for :users
  
  resources :blogs do
    collection do
      post :search
    end
    member do
      get :toggle_status
    end
  end

end
