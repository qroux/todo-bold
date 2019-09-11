class CongratulationJob < ApplicationJob
  queue_as :mailers

  def perform(user_id)
    UserMailer.with(user: user_id).congratulation.deliver_now
  end
end
