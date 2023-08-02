Rails.application.routes.draw do

  constraints(ClientDomainConstraint.new) do
    root 'clients/home#index', as: 'client_root'
    devise_for :users, controllers: {
      sessions: 'clients/sessions'
    }

  end

  constraints(AdminDomainConstraint.new) do
    root 'admins/home#index', as: 'admin_root'
    devise_for :users, controllers: {
      sessions: 'admins/sessions',
      registrations: 'admins/registrations'
    }, as: :admin

  end
end
