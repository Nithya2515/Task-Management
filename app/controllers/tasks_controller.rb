class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET projects/1/tasks
  def index
    @tasks = @project.tasks
  end

  # GET projects/1/tasks/1
  def show
  end

  # GET projects/1/tasks/new
  def new
    @task = @project.tasks.build
    @members =@project.members
  end

  # GET projects/1/tasks/1/edit
  def edit
    @members =@project.members
  end

  # POST projects/1/tasks
  def create
    @task = @project.tasks.build(task_params.merge(report_id: current_user.id))
    @members =@project.members

    if @task.save
      UserMailer.with(task: @task).task.deliver_now
      redirect_to(@task.project)
    else
      render action: 'new'
    end
  end

  # PUT projects/1/tasks/1
  def update
    if @task.update_attributes(task_params) && @task.status =="complete"

      UserMailer.with(task: @task).task_complete.deliver_now
      redirect_to(@task.project)
    else
      render action: 'edit'
    end
  end

  # DELETE projects/1/tasks/1
  def destroy
    @task.destroy

    redirect_to @project
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_task
      @task = @project.tasks.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:name, :description, :status, :project_id, :assign_id)
    end
end
