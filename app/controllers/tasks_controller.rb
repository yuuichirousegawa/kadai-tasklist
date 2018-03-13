class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :current_user, only: [:show, :edit, :destroy, :update]


  def index
   @tasks = Task.all.page(params[:page])
  end
  
  def new
    @task=Task.new
  end
 
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to @task
    else
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @task.destroy
    
    flash[:success] = 'taskは正常に削除されました'
    redirect_back(fallback_location: root_path)
  end

  def update
    @task=Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = 'タスクの更新に成功しました'
      redirect_to @task
    else
      flash.now[:danger]='タスクの更新に失敗しました'
      render :edit
    end
  end
  
  private

  def task_params
    params.require(:task).permit(:content, :status)
  end
end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end

