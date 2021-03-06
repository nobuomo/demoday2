class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]



  def index
    @tasks = Task.all.order("updated_at DESC")
    if params[:title].present?
      @tasks = @tasks.get_by_title params[:title]
      end
    if params[:status].present?
      @tasks = @tasks.get_by_status params[:status]
    end
  end

  # showアククションを定義します。入力フォームと一覧を表示するためインスタンスを2つ生成します。
  def show
    @message = @task.messages.build
    @messages = @task.messages
  end

  def new
    if params[:back]
      @task = Task.new(tasks_params)
    else
      @task = Task.new
    end
  end

  def confirm
    @task = Task.new(tasks_params)
    render 'new' if @task.invalid?
  end

  def create
    @task=Task.new(tasks_params)
    @task.user_id = current_user.id
    if @task.save
      redirect_to tasks_path, notice: "お知らせを作成しました！"

   else
      render 'new'
    end

  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(tasks_params)
    redirect_to tasks_path, notice: "お知らせを編集しました！"
    else
      render action: 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: "お知らせを削除しました！"
  end

  private
    def tasks_params
      params.require(:task).permit(:title, :content, :deadline, :price, :area_id, :status, :image)
    end

    def set_task
      @task = Task.find(params[:id])
    end

end
