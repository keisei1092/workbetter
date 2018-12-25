class TasksController < ApplicationController
  def index
    if params[:sort] == 'due_date'
      @tasks = Task.all
        .sort_by { |t| t.due_date }
        .reverse # due_dateの降順
    else
      @tasks = Task.all
        .sort_by { |t| [t.created_at, t.updated_at].max }
        .reverse # updated_atの降順
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    if @task.save
      flash[:notice] = t('tasks.success.create')
      redirect_to tasks_index_path
    else
      render 'new'
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = t('tasks.success.update')
      redirect_to tasks_show_path
    else
      render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = t('tasks.success.delete')
    redirect_to tasks_index_path
  end

  private

  def task_params
    params.require(:task).permit(:name, :detail, :due_date, :status)
  end
end
