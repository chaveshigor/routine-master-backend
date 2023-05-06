# frozen_string_literal: true

class UserSerializer < ApplicationSerializer
  attribute :firstname do |user|
    user.profile.firstname
  end

  attribute :lastname do |user|
    user.profile.lastname
  end
end

