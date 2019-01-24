# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :rent_charges, path: 'rent-charges'
  resources :rent_charge_statistics, path: 'rent-charge-statistics'
end
