class DailyReportJob < ApplicationJob
  queue_as :default

  def perform
    admin = User.find_by(admin: true)
    UserMailer.with(user: admin.id).reporting.deliver_now
    DailyReportJob.set(wait_until: DateTime.tomorrow.noon - 4.hours).perform_later
  end
end
