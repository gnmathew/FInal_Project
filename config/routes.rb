Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  constraints(ClientDomainConstraint.new) do

  end

  constraints(AdminDomainConstraint.new) do

  end

end
