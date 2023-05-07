# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe Users::CreateForm, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:firstname) }
    it { should validate_presence_of(:lastname) }
  end

  describe '#submit' do
    context 'when params are valid' do
      it 'create user and profile' do
        params = {
          firstname: 'higor',
          lastname: 'chaves',
          email: Faker::Internet.email,
          password: '12345678'
        }
        form = described_class.new(params)

        expect { form.submit }.to change(User, :count).by(1)
                              .and change(Profile, :count).by(1)
      end
    end

    context 'when profile fails to be created' do
      it 'do not create user and profile' do
        profile_instance = instance_double(Profile)
        allow(Profile).to receive(:new).and_return(profile_instance)
        allow(profile_instance).to receive(:assign_attributes)
        allow(profile_instance).to receive(:save).and_raise('Error')

        params = {
          firstname: 'higor',
          lastname: 'chaves',
          email: Faker::Internet.email,
          password: '12345678'
        }
        form = described_class.new(params)

        expect { form.submit }.to change(User, :count).by(0)
                              .and change(Profile, :count).by(0)
      end
    end

    context 'when email is in use' do
      it 'return error' do
        user = create(:user, :with_profile)

        params = {
          firstname: 'higor',
          lastname: 'chaves',
          email: user.email,
          password: '12345678'
        }
        form = described_class.new(params)
        form.submit

        expect(form.errors.to_hash[:email]).to eq(['in use'])
      end
    end
  end
end

