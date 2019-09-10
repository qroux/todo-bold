class TasksController < ApplicationController
  before_action :authenticate_user!

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to lists_path
    else
      flash[:error] = "La tâche n'a pas été créée"
      redirect_to lists_path
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :list_id)
  end
end
