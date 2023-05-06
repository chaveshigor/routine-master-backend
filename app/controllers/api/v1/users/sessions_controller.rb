# frozen_string_literal: true

module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        skip_before_action :verify_authenticity_token
        respond_to :json

        def create
          # binding.pry
          super
        end

        private

        def respond_with(resource, _opts = {})
          # binding.pry
          render json: ::UserSerializer.new(resource).serializable_hash, status: :ok
        end

        def respond_to_on_destroy
          current_user ? log_out_success : log_out_failure
        end

        def log_out_success
          render json: { message: 'Logged out.' }, status: :ok
        end

        def log_out_failure
          render json: { message: 'Logged out failure.' }, status: :unauthorized
        end

        def current_user
          jwt = request.headers.to_h['HTTP_AUTHORIZATION'].split(' ').last
          payload, _header = ::JWT.decode jwt, ENV['DEVISE_JWT_SECRET_KEY'], true, { algorithm: 'HS256' }
          user = User.find_by(jti: payload['jti'])
          return nil if user.blank? || user.id != payload['sub'].to_i

          user
        end

        def current_profile
          current_user&.profile
        end


      end
    end
  end
end

