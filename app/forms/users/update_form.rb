# frozen_string_literal: true

module Users
  class UpdateForm < ::ApplicationForm
    attr_accessor :email, :firstname, :lastname, :id

    def submit
      return false if invalid?

      rescue_errors do
        update_user
        update_profile
      end
    end

    private

    def update_user
      user.assign_attributes(**user_attributes)
      @user.save
    end

    def update_profile
      profile.assign_attributes(**profile_attributes, user: user)
      @profile.save
    end

    def user
      @user = User.find_by(id: id)
    end

    def profile
      @profile = user.profile
    end

    def user_attributes
      {
        email: email
      }.select { |_key, value| value.present? }
    end

    def profile_attributes
      {
        firstname: firstname,
        lastname: lastname
      }.select { |_key, value| value.present? }
    end
  end
end

