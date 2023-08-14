Rails.application.routes.draw do
  constraints(ClientDomainConstraint.new) do
    scope module: :clients do
      root 'home#index'
      get 'users/invite-people', to: 'users#invite_people'
      resources :lottery
      resource :profile, only: [:show, :edit, :update]
      resources :addresses, except: :show
      devise_for :users, controllers: {
        sessions: 'clients/sessions',
        registrations: 'clients/registrations'
      }
    end
  end

  constraints(AdminDomainConstraint.new) do
    scope module: :admins do
      root 'home#index', as: :admin_root
      resources :users, only: [:index]
      resources :categories, except: [:show]
      resources :items do
        member do
          patch :start
          patch :pause
          patch :end
          patch :cancel
        end
      end
      devise_for :users, skip: [:registrations], controllers: {
        sessions: 'admins/sessions'
      }, as: :admin
    end
  end

  namespace :api do
    namespace :v1 do
      resources :regions, only: %i[index show], defaults: { format: :json } do
        resources :provinces, only: :index, defaults: { format: :json }
      end
      resources :provinces, only: %i[index show], defaults: { format: :json } do
        resources :cities, only: :index, defaults: { format: :json }
      end
      resources :cities, only: %i[index show], defaults: { format: :json } do
        resources :barangays, only: :index, defaults: { format: :json }
      end
      resources :barangays, only: %i[index show], defaults: { format: :json }
    end
  end
end
