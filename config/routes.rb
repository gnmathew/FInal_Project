Rails.application.routes.draw do

  constraints(ClientDomainConstraint.new) do

    devise_for :users, controllers: {
      sessions: 'clients/sessions'
    }

  end

  constraints(AdminDomainConstraint.new) do

    devise_for :users, controllers: {
      sessions: 'admins/sessions',
      registrations: 'admins/registrations'
    }, as: :admin

  end
end
