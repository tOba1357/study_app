Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  unauthenticated :user do
    root 'home#index'
  end

  authenticated :user do
    root 'word_cards#index'
    resources :word_cards do
      collection do
        get :study
        get :study_word
      end
      resources :word_card_results, only: [:create]
    end
  end
end
