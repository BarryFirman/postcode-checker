Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # postcode_allow_lists
  resources :postcode_allow_lists, only: [:index, :new, :create, :destroy]
end
