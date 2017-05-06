Rails.application.routes.draw do
  resources :exams
  resources :assessments
  resources :disciplines
  devise_scope :user do
    get "/signin" => "users/sessions#new", as: "new_user_session"
    post "/signin" => "users/sessions#create", as: "user_session"
    get "/signout" => "users/sessions#destroy", as: "destroy_user_session"
    get "/signup" => "users/registrations#new", as: "new_user_registration"
  end
  devise_for :users, skip: [:sessions], controllers: {
      registrations: 'users/registrations',
      passwords: 'users/passwords',
      invitations: 'users/invitations'
  }
  resources :users, only: [:index, :edit, :destroy, :update]
  root 'welcome#index'
end
