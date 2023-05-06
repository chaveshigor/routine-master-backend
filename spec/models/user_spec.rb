# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }

  describe 'associations' do
    it { should have_one(:profile) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end
end
