class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.congratulation.subject
  #
  def congratulation
    @user = User.find(params[:user])
    mail(to: @user.email, subject: 'Mission accomplie')
  end
end
