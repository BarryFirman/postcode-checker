Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'postcode_checker#new'
  # postcode_allow_lists
  resources :postcode_allow_lists, only: %i[index new create edit update destroy]

  # postcode_checker
  post 'check_postcode', to: 'postcode_checker#check'


end
