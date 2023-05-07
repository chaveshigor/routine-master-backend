# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ApplicationController
      skip_before_action :verify_authenticity_token
      around_action :raise_to_honeybadger

      respond_to :json

      def authenticate_user!
        return render json: {}, status: :unauthorized if current_user.blank?
      end

      def current_user
        jwt = begin
          response = request.headers.to_h['HTTP_AUTHORIZATION']&.split(' ')&.last
          response = request.headers.to_h.dig('rack.request.query_hash', 'headers', 'Authorization')&.split(' ')&.last if response.blank?
          response
        end

        return nil if jwt.blank?

        payload, _header = ::JWT.decode jwt, ENV['DEVISE_JWT_SECRET_KEY'], true, { algorithm: 'HS256' }
        user = User.find_by(jti: payload['jti'])
        return nil if user.blank? || user.id != payload['sub'].to_i

        user
      end

      def current_profile
        current_user&.profile
      end

      private

      def raise_to_honeybadger
        yield
      rescue => exception
        error_context = {
          current_user: current_user.present? ? current_user : nil,
          current_profile: current_profile.present? ? current_profile : nil
        }

        Honeybadger.notify(exception, context: error_context)
        raise exception
      end
    end
  end
end

