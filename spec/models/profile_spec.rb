# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profile, type: :model do
  subject { create(:profile, :with_user) }

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:firstname) }
    it { should validate_presence_of(:lastname) }
  end
end

