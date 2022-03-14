class TasksController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create destroy search]
  before_action :user_profile?
  before_action :find_task, only: %i[edit update show confirm_delete destroy delete_comment]
  skip_before_action :verify_authenticity_token, only: %i[search]

  def index
    @task = Task.where(user: [current_user])

    case params[:order]
    when 'highest priority'
      @task = Task.all.order('priority desc')
    when 'lowest priority'
      @task = Task.all.order('priority asc')
    when 'newest'
      @task = Task.all.order('created_at asc')
    when 'oldest'
      @task = Task.all.order('created_at desc')
    when 'complete first'
      @task = Task.all.order('status desc')
    when 'incomplete first'
      @task = Task.all.order('status asc')
    when 'title desc'
      @task = Task.all.order('title desc')
    when 'title asc'
      @task = Task.all.order('title asc')
    else
      @task = Task.where(user: [current_user])
    end
  end

  def show

    @task=Task.find(params[:id])

    if @task.user != current_user
      redirect_to root_path, alert: "Sem permissão para ver essa Task"
    end

    #Tentativa de fazer os pluses e minuses funcionarem
    # if params[:plus]
    #   Pluse.new(comment_id: params[:comment])
    #   ###@task.comments.where(id: params[:comment]).first.pluses
    # elsif params[:minus]
    #   Minus.new(comment_id: params[:comment])
    # end

    #Criar método
    case params[:order]
    when 'biggest score'
    @task = Task.joins(:comments).merge(Comment.order(pluses: :desc))
    when 'lowest score'
    @task = Task.joins(:comments).merge(Comment.order(pluses: :asc))
    end

    #Criar método
    if Rails.application.routes.recognize_path(request.referrer)[:action] == 'show'
      if @task.save
        if @task.share == false
          flash[:notice] = 'This Task is Private'
        else
          flash[:notice] = 'This Task is Public'
        end
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    @task.user = current_user
    if @task.save
      flash[:notice] = 'Task Created!'
      redirect_to @task
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:notice] = 'Task Updated!'
      redirect_to @task
    else
      render :edit
    end
  end

  def destroy
    @task.comments.clear
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_path, notice: "Task apagada!" }
      format.json { head :no_content }
    end
  end

  def complete
  end

  def incomplete
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :status, :priority, :share, :user_id, :comment_id)
  end

  def comment_params
  end

  def sanitize_sql_like(string, escape_character = "\\")
    pattern = Regexp.union(escape_character, "%", "_")
    string.gsub(pattern) { |x| [escape_character, x].join }
  end

  def find_task
    @task = Task.find(params[:id])
  end
end

