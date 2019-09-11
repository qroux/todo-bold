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

  def reporting
    @admin = User.find_by(admin: true)

    @users = User.count
    @tasks_created = Task.where(done: false, created_at: 24.hours.ago..Time.now).count
    @tasks_completed = Task.where(done: true, updated_at: 24.hours.ago..Time.now).count

    mail(to: @admin.email, subject: 'Statistiques journalières')
  end
end
