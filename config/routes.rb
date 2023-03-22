Rails.application.routes.draw do
  resources :applicants do
    patch :change_stage, on: :member
  end
  resources :offers
  devise_for :members,
 path: '',
  controllers: {
    registrations: 'members/registrations',
     sessions: 'members/sessions',
  },
  path_names: {
    sign_in: 'login',
    password: 'forgot',
    confirmation: 'confirm',
    sign_up: 'sign_up',
    sign_out: 'signout'
  }

  get 'dashboard/show'
  # root to: 'dashboard#show'
  
  authenticate :member do
   root to: 'dashboard#show'
  # root to: 'dashboard#show', as: :member_root
  end

 # devise_scope :member do
   # root to: 'devise/sessions#new'
  #end
end