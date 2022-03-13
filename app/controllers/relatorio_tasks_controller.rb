class RelatorioTasksController < ApplicationController

  before_action :authenticate_user!, only: %i[index new create destroy search]
  skip_before_action :verify_authenticity_token, only: %i[search]

  def index
    @task = Task.where(user_id: [current_user.id])
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :status, :priority, :share, :user_id, :comment_id)
  end

  def comment_params
  end
end