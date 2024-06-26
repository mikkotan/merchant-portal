# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      resources :merchants, only: :index
      resources :partners, only: %i[index show]
      resources :pipelines, only: %i[create] do
        member do
          post :activate
        end
      end
    end
  end
end
