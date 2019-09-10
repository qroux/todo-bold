class ListsController < ApplicationController
  before_action :authenticate_user!

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

  def new
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

  private

  def list_params
    params.require(:list).permit(:title)
  end
end
