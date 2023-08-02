Rails.application.routes.draw do

  constraints(ClientDomainConstraint.new) do
    scope module: :clients do
      root 'home#index'
      resource :profile, only: [:show, :edit, :update]
      devise_for :users, controllers: {
        sessions: 'clients/sessions',
        registrations: 'clients/registrations'
      }
    end
  end

  constraints(AdminDomainConstraint.new) do
    scope module: :admins do
      root 'home#index', as: :admin_root
      devise_for :users, controllers: {
        sessions: 'admins/sessions'
      }, as: :admin
    end
  end
end
