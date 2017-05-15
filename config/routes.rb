Rails.application.routes.draw do
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

  resources :disciplines do
    get 'get_students_for_discipline', to: 'disciplines#get_students_for_discipline'
    get 'edit_students', to: 'disciplines#edit_students'
    post 'update_students', to: 'disciplines#update_students'
  end

  resources :exams do
    get 'edit_assessments', to: 'exams#edit_assessments'
    post 'update_assessments', to: 'exams#update_assessments'
  end

  resources :assessments
  resources :users, only: [:index, :edit, :destroy, :update]

  root 'welcome#index'
end
