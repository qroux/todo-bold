class ListsController < ApplicationController
  before_action :set_list, only: [:show, :destroy, :add_collaborator]

  def index
    if current_user.admin == true
      @lists = List.all
    else
      @lists = List.where(user_id: current_user.id).includes(:tasks)
    end

    # List and Task #new inside #index controller for ux purpose
    @list = List.new(title: '') # title: '' fix the simple_form placeholder
    @task = Task.new(name: '')
  end

  def show
    # attempt to grant #show access to collaborators
    @list ||= begin
      result = List.find_by(id: params[:id])
      @list = result if result.collaborators.include?(current_user.email)
    end

    #if @list still nil after trying to grant access to collaborators
    if @list.nil?
      redirect_back(fallback_location: root_path)
    else
      @tasks = @list.tasks.where(done: false)
      @tasks_completed = @list.tasks.where(done: true)
    end
  end

  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id
    @list.collaborators.push(current_user.email)
    @list.title = 'Nouvelle liste' if @list.title == ''
    if @list.save
      redirect_to lists_path
    else
      render :index
    end
  end

  def destroy
    if @list.destroy
      redirect_to lists_path
    else
      flash[:error] = "La liste n'a pu être supprimée"
      redirect_to lists_path
    end
  end

  def add_collaborator
    if params[:query].present?
      unless User.find_by(email: params[:query]).nil?
        @list.collaborators.push(params[:query])
        @list.shared = true
        @list.save
      end

      redirect_to list_path(@list)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def shared
    if current_user.admin == true
      @lists = List.where(shared: true).includes(:tasks)
    else
      @lists = []
      results = List.where(shared: true)

      results.each do |result|
        if result.collaborators.include?(current_user.email)
          @lists << result
        end
      end
    end

    @list = List.new(title: '')
    @task = Task.new(name: '')
  end

  private

  def list_params
    params.require(:list).permit(:title)
  end

  def set_list
    if current_user.try(:admin?)
      @list = List.find(params[:id])
    else
      @list = List.find_by(id: params[:id], user_id: current_user.id)
    end
  end
end
