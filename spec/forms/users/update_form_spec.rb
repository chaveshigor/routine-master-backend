# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe Users::UpdateForm, type: :model do
  subject(:form) { described_class.new }

  describe 'validations' do
    it { should validate_presence_of(:user) }
  end

  describe '#submit' do
    context 'when attributes are valid' do
      it 'update user info', :aggregate_failures do
        user = create(:user, :with_profile)

        params = {
          firstname: 'higor',
          lastname: 'chaves',
          user: user
        }

        form = described_class.new(params)
        form.submit

        user.reload

        expect(user.profile.firstname).to eq(params[:firstname])
        expect(user.profile.lastname).to eq(params[:lastname])
      end
    end
  end
end

