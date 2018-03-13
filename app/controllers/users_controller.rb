class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :destroy, :update]
  
  def index
    @users = User.all.page(params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.order('created_at DESC').page(params[:page])
    counts(@user)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
  
    if @user.save
    flash[:success] = 'ユーザー登録に成功しました'
    redirect_to @user
    else
    flash.now[:danger] = 'ユーザー登録に失敗しました'
    render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user=User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = '更新に成功しました'
      redirect_to @user
    else
      flash.now[:danger] = '更新に失敗しました'
      render :edit
    end
  end
  
  def destroy
    @user=User.find(params[:id])
    @user.destroy
    flash[:success] = '退会しました'
    redirect_to users_url
  end
    
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
