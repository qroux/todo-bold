class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: [:destroy]

  def index
    if current_user.admin == true
      @lists = List.all
    else
      @lists = List.where(user_id: current_user.id)
    end

    # List and Task #new inside #index controller for ux purpose
    @list = List.new(title: '') # title: '' fix the simple_form placeholder
    @task = Task.new(name: '')
  end

  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id
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

  private

  def list_params
    params.require(:list).permit(:title)
  end

  def set_list
    @list = List.find(params[:id])
  end
end
