Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects, only: [:create, :destroy, :show] do
    collection do
      get ':id/cropper' => 'projects#cropper'
      post 'preprocess' => 'projects#preprocess'
    end
  end

  root 'home#index'
end
