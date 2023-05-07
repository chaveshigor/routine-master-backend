# frozen_string_literal: true

module Api
  module V1
    module Users
      class RegistrationController < Api::V1::ApplicationController
        before_action :authenticate_user!, only: %i[show update]

        def create
          @form = ::Users::CreateForm.new(**create_user_params.to_h.symbolize_keys)

          if @form.submit
            render json: ::UserSerializer.new(@form.user).serializable_hash, status: :created
          else
            render json: ::ErrorSerializer.new(@form.errors).serializable_hash, status: :bad_request
          end
        end

        def show
          render json: ::UserSerializer.new(current_user).serializable_hash
        end

        def update
          @form = ::Users::UpdateForm.new(**update_user_params.to_h.symbolize_keys, user: current_user)

          if @form.submit
            render json: {}, status: :ok
          else
            render json: {}, status: :bad_request
          end
        end

        def destory; end

        private

        def create_user_params
          params.require(:user).permit(:email, :password, :firstname, :lastname)
        end

        def update_user_params
          params.require(:user).permit(:firstname, :lastname)
        end
      end
    end
  end
end

