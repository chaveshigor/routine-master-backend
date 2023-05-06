# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    scope :v1 do
      devise_for :users, controllers: {
        sessions: 'api/v1/users/sessions',
        registrations: 'api/v1/users/registration',
        skip: :sessions
      }

      namespace :users do
        get '/', to: '/api/v1/users/registration#show'
      end
    end
  end
end

