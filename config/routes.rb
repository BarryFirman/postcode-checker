Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # postcode_allow_lists
  # get '/postcode_allow_lists', to: 'postcode_allow_lists#index'
  # get '/postcode_allow_lists/new', to: 'postcode_allow_lists#new'
  # post 'postcode_allow_lists', to: 'postcode_allow_lists#create'
  # delete 'postcode_allow_lists/:id', to: 'postcode_allow_lists#destroy', as: 'postcode_allow_list'
  resources :postcode_allow_lists, only: [:index, :new, :create, :destroy]
end
