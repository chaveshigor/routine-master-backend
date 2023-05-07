# frozen_string_literal: true

class AccountMailer < Devise::Mailer
  default from: ENV['EMAIL_ADDRESS']

  def confirmation_instructions(*args)
    @user = args[0]
    @confirmation_token = args[1]
    @url = "url/#{@confirmation_token}"
    mail(to: @user.email, subject: "Bem vindo(a) #{@user.profile.firstname.capitalize}")
  end
end

