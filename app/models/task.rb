class Task < ApplicationRecord
  belongs_to :list

  # after_update :send_congratulation_mail?

  private

  # congratualtion mail moved to Task#done controller

  # def send_congratulation_mail?
  #   # try to convert this action as a job with sidekiq to fix Task#update test
  #   tasks = Task.where(list_id: list_id, done: false)

  #   if tasks.count.zero?
  #     UserMailer.with(user: list.user.id).congratulation.deliver_now
  #   end
  # end
end
