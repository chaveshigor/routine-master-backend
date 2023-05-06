# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :user_id, presence: true
end

