PageApi::Application.routes.draw do
  namespace 'api' do
    resources :pages, except: [:new, :edit] do
      collection do
        get :published
        get :unpublished
      end
      member do
        get :publish
        get :total_words
      end
    end
  end

  resource :sessions, only: [:new, :create, :destroy]

  match '/main' => 'main#index'

  root to: 'sessions#new'
end
