Rails.application.routes.draw do
  get 'postcode_checker/check'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'
  # postcode_allow_lists
  resources :postcode_allow_lists, only: [:index, :new, :create, :destroy]


end
