class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:update, :done, :undo]

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to lists_path
    else
      flash[:error] = "La tâche n'a pas été créée"
      redirect_to lists_path
    end
  end

  def update
    if @task.update!(task_params)
      redirect_to lists_path
    else
      flash[:error] = "La tâche n'a pas été mise à jour"
      redirect_to lists_path
    end
  end

  def done
    @task.done = true
    if @task.save
      redirect_to lists_path

      # need to move this action as a sidekiq job for performance
      tasks = Task.where(list_id: @task.list_id, done: false)

      if tasks.count.zero?
        UserMailer.with(user: current_user.id).congratulation.deliver_now
      end
    else
      flash[:error] = "La tâche n'a pas été mise à jour"
      redirect_to lists_path
    end
  end

  def undo
    @task.done = false
    if @task.save
      redirect_to lists_path
    else
      flash[:error] = "La tâche n'a pas été mise à jour"
      redirect_to lists_path
    end
  end

  private

  def task_params
    params.require(:task).permit(:id, :name, :list_id)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
