class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = Task.order(created_at: :desc).page(params[:page]).per(3)
  end
  
  def show
  end
  
  def new
    @task=Task.new
  end
  
  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success]= "Taskが正常に投稿されました"
      redirect_to @task
    else
      flash.now[:danger]="Taskの投稿に失敗しました"
      render :new
    end
  end
  
  def edit
  end
  
  
  def update
    if @task.update(task_params)
      flash[:success] = "Taskの更新に成功しました"
      redirect_to @task
    else
      flash.now[:danger] = "Taskの更新に失敗しました"
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = "Taskの削除に成功しました"
    redirect_to tasks_url
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
end
