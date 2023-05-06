# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user, required: true

  validates :firstname, presence: true
  validates :lastname, presence: true
end

