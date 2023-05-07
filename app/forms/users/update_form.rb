# frozen_string_literal: true

module Users
  class UpdateForm < ::ApplicationForm
    attr_accessor :firstname, :lastname, :user

    validates :user, presence: true

    def submit
      return false if invalid?

      rescue_errors do
        update_profile
      end
    end

    private

    def update_profile
      profile.assign_attributes(**profile_attributes, user: user)
      @profile.save
    end

    def profile
      @profile = user.profile
    end

    def profile_attributes
      {
        firstname: firstname,
        lastname: lastname
      }.select { |_key, value| value.present? }
    end
  end
end

