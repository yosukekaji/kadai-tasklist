class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :check_user, only: [:show, :edit, :update, :destroy]
  # before_action :correct_user, ...

  def index
    @tasks = Task.all
    # @tasks = Task.where(user_id: current_user.id)
    # Userクラスにhas_many :tasksと書くことで使用可能になる
    @tasks = current_user.tasks
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    
    if @task.save
      flash[:success] = 'Task が正常に入力されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が入力されませんでした'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = 'Task は正常に入力されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は入力されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy
    
    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def check_user
    @task = Task.find_by(id: params[:id])
    redirect_to root_url if @task.blank? || @task.user != current_user
  end
  
end