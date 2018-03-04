class TasksController < ApplicationController
  
  def index
    @tasks = Task.all
  end
  
  def show
    @task = Task.find(params[:id])
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
    @task = Task.find(params[:id])
  end
  
  
  def update
    @task = Task.find(params[:id])
    
    if @task.update
      flash[:success] = "Taskの更新に成功しました"
      redirect_to @task
    else
      flash.now[:danger] = "Taskの更新に失敗しました"
      render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = "Taskの削除に成功しました"
    redirect_to tasks_url
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content)
  end
end
