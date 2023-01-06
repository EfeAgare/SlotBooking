Rails.application.routes.draw do
  root 'api/v1/slot#index'

  namespace :api do
    namespace :v1 do
     resources :slot, only: [:index, :create]
     resources :new_slot, only: [:index, :create]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
