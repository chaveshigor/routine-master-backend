# frozen_string_literal: true

require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe Api::V1::Users::RegistrationController, type: :controller do
  describe 'GET /users' do
    it 'show user info' do
      user = create(:user, :with_profile)
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)

      get :show, params: { headers: auth_headers }

      expect(response.body).to eq(::UserSerializer.new(user).to_json)
    end
  end

  describe 'PUT /users' do
    
  end

  describe 'POST /users' do
    
  end
end

