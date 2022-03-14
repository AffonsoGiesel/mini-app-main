class HomeController < ApplicationController
  before_action :user_profile?

  def index
    if current_user
      @tasks = Task.where(share: true).last(3)
    else
      @tasks = Task.first(3)
    end

    if params[:search_by_title] && params[:search_by_title] != ""
      @tasks = Task.where("title like ?", "#{params[:search_by_title]}%")
    end
  end
end
