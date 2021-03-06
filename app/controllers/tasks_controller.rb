class TasksController < ApplicationController
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
      redirect_back(fallback_location: root_path)

      tasks = Task.where(list_id: @task.list_id, done: false)

      if tasks.count.zero?
        CongratulationJob.perform_later(current_user.id)
      end
    else
      flash[:error] = "La tâche n'a pas été mise à jour"
      redirect_to lists_path
    end
  end

  def undo
    @task.done = false
    if @task.save
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "La tâche n'a pas été mise à jour"
      redirect_to lists_path
    end
  end

  def search
    if params[:query].present?
      # pg search also includes List.title in the research through associated model
      @tasks = Task.search_by_name(params[:query])
    else
      @tasks = []
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
