Rails.application.routes.draw do

  constraints(ClientDomainConstraint.new) do
    root 'home#index', as: 'client_path'
    devise_for :users, controllers: {
      sessions: 'devise/sessions'
    }


  end

  constraints(AdminDomainConstraint.new) do
    root 'admin/home#index', as: 'admin_path'
    devise_for :users, controllers: {
      sessions: 'admin/sessions',
      registrations: 'admin/registrations'
    }, as: :admin_users




  end
end
