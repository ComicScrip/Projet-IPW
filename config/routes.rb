Rails.application.routes.draw do
  devise_scope :user do
    get "/signin" => "users/sessions#new", as: "new_user_session"
    post "/signin" => "users/sessions#create", as: "user_session"
    get "/signout" => "users/sessions#destroy", as: "destroy_user_session"
    get "/signup" => "users/registrations#new", as: "new_user_registration"
  end
  resources :users, only: [:index, :show]
  devise_for :users, skip: [:sessions], controllers: {registrations: 'users/registrations', passwords: 'users/passwords'}
  root 'welcome#index'
end
