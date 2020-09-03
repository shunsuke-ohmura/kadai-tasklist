class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :set_task, only: [:show, :edit, :update,:destroy]
    before_action :current_user, only: [:destroy]
   
    def index
        @tasks = current_user.tasks.all.page(params[:page])
    end

    def show
    end

    def new
        @task = Task.new
    end

    def create
       # @tasks = Task.new(task_params)
       @task = current_user.tasks.build(task_params)
      # @tasks.user_id = current_user.id
    if @task.save
      flash[:success] = 'タスクを投稿しました。'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'タスクの投稿に失敗しました。'
      render 'toppages/index'
    end

    #if @task.save
       # flash[:success] = 'Task が正常に投稿されました'
       # redirect_to @task
  #  else
       # flash.now[:danger] = 'Task が投稿されませんでした'
       # render :new
   # end
    end

    def edit
    end

    def update

        if @task.update(task_params)
            flash[:success] = 'Task は正常に更新されました'
            redirect_to @task
        else
            flash.now[:danger] = 'Task は更新されませんでした'
            render :edit
        end
    end

    def destroy
        @task.destroy
        flash[:success] = 'Task は正常に削除されました'
        redirect_to tasks_url
      #  redirect_back(fallback_location: root_path)
    end
    
    private
    
    def set_task
        @task = Task.find(params[:id])
    end
    def task_params
        params.require(:task).permit(:id, :content, :status)
    end
    
    def correct_user
        @task = current_user.tasks.user.find_by(id: params[:id])
    unless @task
        redirect_to root_url
    end
    end
end