Rails.application.routes.draw do

  constraints(ClientDomainConstraint.new) do
    root 'clients/home#index', as: 'client_root'
    devise_for :users, controllers: {
      sessions: 'clients/sessions',
      registrations: 'clients/registrations'
    }

  end

  constraints(AdminDomainConstraint.new) do
    root 'admins/home#index', as: 'admin_root'
    devise_for :users, controllers: {
      sessions: 'admins/sessions'

    }, as: :admin

  end
end
