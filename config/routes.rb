Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  authenticated :user do
    resources :word_cards do
      collection do
        get :study
      end
    end
  end
end
