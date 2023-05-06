# frozen_string_literal: true

module Users
  class CreateForm < ::ApplicationForm
    attr_reader :user, :profile
    attr_accessor :email, :password, :firstname, :lastname

    validates :email, presence: true
    validates :password, presence: true
    validates :firstname, presence: true
    validates :lastname, presence: true

    def submit
      return false if invalid?

      rescue_errors do
        create_user
        create_profile
      end
    end

    private

    def create_user
      @user = User.new
      @user.assign_attributes(email: email, password: password, jti: SecureRandom.uuid)
      @user.save
    end

    def create_profile
      @profile = Profile.new
      @profile.assign_attributes(firstname: firstname, lastname: lastname, user: @user)
      @profile.save
    end
  end
end

